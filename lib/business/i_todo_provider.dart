import 'package:flutter/material.dart';
import 'package:todo_list/models/todo_model.dart';

abstract class ITodoProvider with ChangeNotifier {
  Future<List<TodoModel>> get modelsListFuture;
  Future<List<TodoModel>> getOfflineItems();
  Future<List<TodoModel>> getItemsFromNetwork();
  Future refreshList(List<TodoModel> list);

  Future<TodoModel> getConcreteItem(String uid);
  Future addItem(TodoModel item);
  Future updateItem(TodoModel item);
  Future deleteItem(TodoModel item);

  int get itemsDone;
}
