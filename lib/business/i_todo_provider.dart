import 'package:flutter/material.dart';
import 'package:todo_list/models/todo_model.dart';

abstract class ITodoProvider with ChangeNotifier {
  Future<List<TodoModel>> get modelsListFuture;
  Future<List<TodoModel>> getItems();
  Future refreshList(List<TodoModel> list);

  Future addItem(TodoModel item);
  Future updateItem(TodoModel item);
  Future deleteItem(TodoModel item);
  int get totalItems;
  int get itemsDone;
}
