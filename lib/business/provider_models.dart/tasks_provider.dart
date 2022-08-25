import 'package:dio/dio.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter/cupertino.dart';
import 'package:get_it/get_it.dart';
import 'package:logger/logger.dart';
import 'package:todo_list/models/todo_model.dart';
import 'package:todo_list/models/todo_model_domain.dart';
import '../repository/local_tasks_repository.dart';
import '../repository/remote_tasks_repository.dart';

class TasksProvider with ChangeNotifier {
  List<DomainTodoModel> _tasks = [];
  List<DomainTodoModel> get tasks => _tasks;

  bool _isLoaded = false;
  bool get isLoaded => _isLoaded;

  late RemoteTasksRepository _remoteRepository;
  late LocalTasksRepository _localRepository;
  late FirebaseAnalytics _analytics;
  TasksProvider() {
    _remoteRepository = GetIt.I<RemoteTasksRepository>();
    _localRepository = GetIt.I<LocalTasksRepository>();
    _analytics = GetIt.I<FirebaseAnalytics>();
  }

  Future<void> fetchTodoList() async {
    try {
      var remoteRevision = await _remoteRepository.getRevision();
      var localRevision = await _localRepository.getRevision();

      if (localRevision < remoteRevision) {
        var tasksList = await _remoteRepository.getTodoList();
        await _localRepository.refreshList(tasksList);
      } else if (localRevision > remoteRevision) {
        var tasksList = await _localRepository.getTodoList();
        await _remoteRepository.refreshList(tasksList);
      }
      _localRepository.setRevision(remoteRevision);

      _tasks = List.from(
        (await _localRepository.getTodoList()).toTodoModelDomainList(),
      );
      _isLoaded = true;
      notifyListeners();
    } catch (e) {
      _tasks = List.from(
        (await _localRepository.getTodoList()).toTodoModelDomainList(),
      );
      _isLoaded = true;
      notifyListeners();
    }
  }

  Future addItem(DomainTodoModel item) async {
    await _localRepository.addItem(item.toTodoModel());
    _tasks = List.from([..._tasks, item]);
    notifyListeners();

    try {
      await _remoteRepository.addItem(item.toTodoModel());
      _analytics.logEvent(name: 'add_todo');
    } catch (e) {
      Logger().e("Failed to add item on server");
    }
  }

  Future deleteItem(DomainTodoModel item, {bool needRebuild = false}) async {
    await _localRepository.deleteItem(item.toTodoModel());
    _tasks = List.from(_tasks);
    _tasks.remove(item);
    if (needRebuild) notifyListeners();

    try {
      await _remoteRepository.deleteItem(item.toTodoModel());
      _analytics.logEvent(name: "remove_todo");
    } catch (e) {
      Logger().e("Failed to delete item on server");
    }
  }

  Future updateItem(DomainTodoModel item) async {
    _localRepository.updateItem(item.toTodoModel());
    _tasks = List.from(_tasks);
    var index = _tasks.indexWhere((element) => element.id == item.id);
    _tasks.removeAt(index);
    _tasks.insert(index, item);
    notifyListeners();

    try {
      await _remoteRepository.updateItem(item.toTodoModel());
      _analytics.logEvent(name: "update_todo");
    } on DioError {
      Logger().e("Failed to update item on server\n");
    }
  }

  int get totalItems => _tasks.length;
  int get itemsDone => _tasks.where((e) => e.done).length;
}

extension TodoModelListExt on List<TodoModel> {
  List<DomainTodoModel> toTodoModelDomainList() {
    return map((e) {
      return DomainTodoModel(
        id: e.id,
        text: e.text,
        color: e.color,
        importance: e.importance,
        done: e.done,
        deadline: e.deadline,
        changedAt: e.changedAt,
        createdAt: e.createdAt,
        lastUpdatedBy: e.lastUpdatedBy,
      );
    }).toList();
  }
}

extension TodoModelDomainExt on DomainTodoModel {
  TodoModel toTodoModel() {
    return TodoModel(
      importance: importance,
      id: id,
      text: text,
      done: done,
      changedAt: changedAt,
      createdAt: createdAt,
      lastUpdatedBy: lastUpdatedBy,
    );
  }
}
