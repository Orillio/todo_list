import '../../models/todo_model.dart';

abstract class Api {
  Future<int> getUpToDateRevision();
  Future<List<TodoModel>> getTasksList();
  Future<void> addItem(TodoModel model);
  Future<void> updateList(List<TodoModel> model);
  Future<void> deleteItem(String id);
  Future<void> updateItem(TodoModel model);
}
