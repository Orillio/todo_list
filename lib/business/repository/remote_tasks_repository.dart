import 'package:get_it/get_it.dart';
import 'package:todo_list/business/repository/tasks_repository.dart';
import 'package:todo_list/models/todo_model.dart';

import '../api/api.dart';

class RemoteTasksRepository implements TasksRepository {
  
  late Api _api;

  RemoteTasksRepository({Api? api}) {
    _api = api ?? GetIt.I<Api>();
  }

  @override
  Future<void> addItem(TodoModel item) async {
    await _api.addItem(item);
  }

  @override
  Future<void> deleteItem(TodoModel item) async {
    await _api.deleteItem(item.id);
  }

  @override
  Future<List<TodoModel>> getTodoList() async {
    return _api.getTasksList();
  }

  @override
  Future<void> refreshList(List<TodoModel> list) async {
    await _api.updateList(list);
  }

  @override
  Future<void> updateItem(TodoModel item) async {
    await _api.updateItem(item);
  }

  @override
  Future<int> getRevision() async {
    return _api.getUpToDateRevision();
  }
}
