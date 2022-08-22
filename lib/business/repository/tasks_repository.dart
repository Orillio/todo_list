import 'package:todo_list/models/todo_model.dart';

abstract class TasksRepository {
  Future<int> getRevision();
  Future<List<TodoModel>> getTodoList();
  Future<void> refreshList(List<TodoModel> list);
  Future<void> addItem(TodoModel item);
  Future<void> updateItem(TodoModel item);
  Future<void> deleteItem(TodoModel item);
}
