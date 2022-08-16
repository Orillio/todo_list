import '../../models/todo_model.dart';

abstract class Api {
  Future<int> getUpToDateRevision();
  Future<List<TodoModel>> getTasksList();
  Future addItem(TodoModel model);
  Future updateList(List<TodoModel> model);
  Future deleteItem(String id);
  Future updateItem(TodoModel model);
}
