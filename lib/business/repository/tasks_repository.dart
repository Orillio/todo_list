import 'package:todo_list/models/todo_model.dart';

abstract class TasksRepository {
  Future<int> getRevision();
  Future<List<TodoModel>> getTodoList();
  Future refreshList(List<TodoModel> list);
  Future addItem(TodoModel item);
  Future updateItem(TodoModel item);
  Future deleteItem(TodoModel item);
}
