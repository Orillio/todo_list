import 'package:dio/dio.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter/cupertino.dart';
import 'package:get_it/get_it.dart';
import 'package:logger/logger.dart';
import 'package:todo_list/models/todo_model.dart';
import '../repository/local_tasks_repository.dart';
import '../repository/remote_tasks_repository.dart';

class TasksProvider with ChangeNotifier {
  List<TodoModel>? _tasks;
  List<TodoModel>? get tasks => _tasks;

  late RemoteTasksRepository _remoteRepository;
  late LocalTasksRepository _localRepository;
  late FirebaseAnalytics _analytics;
  TasksProvider() {
    _remoteRepository = GetIt.I<RemoteTasksRepository>();
    _localRepository = GetIt.I<LocalTasksRepository>();
    _analytics = GetIt.I<FirebaseAnalytics>();
  }

  Future<List<TodoModel>> getTodoList() async {
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

      _tasks = List.from(await _localRepository.getTodoList());
      return tasks!;
    } catch (e) {
      _tasks = List.from(await _localRepository.getTodoList());
      return _tasks!;
    }
  }

  Future addItem(TodoModel item) async {
    await _localRepository.addItem(item);
    _tasks?.add(item);
    notifyListeners();

    try {
      await _remoteRepository.addItem(item);
      _analytics.logEvent(name: 'add_todo');
    } catch (e) {
      Logger().e("Failed to add item on server");
    }
  }

  Future deleteItem(TodoModel item, {bool needRebuild = false}) async {
    await _localRepository.deleteItem(item);
    _tasks?.remove(item);

    try {
      await _remoteRepository.deleteItem(item);
      _analytics.logEvent(name: "remove_todo");
    } catch (e) {
      Logger().e("Failed to delete item on server");
    }
    if (needRebuild) notifyListeners();
  }

  Future updateItem(TodoModel item) async {
    _localRepository.updateItem(item);
    _tasks?.firstWhere((element) => element.id == item.id).pasteFromOther(item);
    notifyListeners();

    try {
      await _remoteRepository.updateItem(item);
      _analytics.logEvent(name: "update_todo");
    } on DioError {
      Logger().e("Failed to update item on server\n");
    }
  }

  int get totalItems => _tasks?.length ?? 0;
  int get itemsDone => _tasks?.where((e) => e.done).length ?? 0;
}
