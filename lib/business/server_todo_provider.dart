import 'package:flutter/cupertino.dart';
import 'package:todo_list/business/api/back_api.dart';
import 'package:todo_list/models/todo_model.dart';
import 'i_todo_provider.dart';

class ServerTodoProvider with ChangeNotifier implements ITodoProvider {

  static var api = BackApi();

  @override
  Future addItem(TodoModel item) {
    // TODO: implement addItem
    throw UnimplementedError();
  }

  @override
  Future deleteItem(TodoModel item) {
    // TODO: implement deleteItem
    throw UnimplementedError();
  }

  @override
  Future<TodoModel> getConcreteItem(String uid) {
    // TODO: implement getConcreteItem
    throw UnimplementedError();
  }

  @override
  Future<List<TodoModel>> getItemsFromNetwork() {
    // TODO: implement getItemsFromNetwork
    throw UnimplementedError();
  }

  @override
  Future<List<TodoModel>> getOfflineItems() {
    // TODO: implement getOfflineItems
    throw UnimplementedError();
  }

  @override
  // TODO: implement itemsDone
  int get itemsDone => throw UnimplementedError();

  @override
  Future refreshList(List<TodoModel> list) {
    // TODO: implement refreshList
    throw UnimplementedError();
  }

  @override
  Future updateItem(TodoModel item) {
    // TODO: implement updateItem
    throw UnimplementedError();
  }

}