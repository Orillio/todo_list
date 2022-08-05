import 'package:flutter/cupertino.dart';
import 'package:todo_list/business/api/back_api.dart';
import 'package:todo_list/models/todo_model.dart';
import 'i_todo_provider.dart';

class ServerTodoProvider with ChangeNotifier implements ITodoProvider {
  static var api = BackApi();
  List<TodoModel>? _offlineItems;

  @override
  int get itemsDone => _offlineItems?.where((e) => e.done).length ?? 0;

  @override
  Future<List<TodoModel>> get modelsListFuture async {
    return _offlineItems ??= await getItemsFromNetwork();
  }

  @override
  Future addItem(TodoModel item) async {
    await api.addItem(item);
    _offlineItems?.add(item);
    notifyListeners();
  }

  @override
  Future deleteItem(TodoModel item) async {
    await api.deleteItem(item.id);
    _offlineItems?.removeWhere((e) => e.id == item.id);
    notifyListeners();
  }

  @override
  Future<TodoModel> getConcreteItem(String uid) async {
    return TodoModel.fromMap(api.getItem(uid));
  }

  @override
  Future<List<TodoModel>> getItemsFromNetwork() async {
    var responseList = (await api.getList());
    return (responseList as List<dynamic>).map((e) {
      return TodoModel.fromMap(e);
    }).toList();
  }

  @override
  Future<List<TodoModel>> getOfflineItems() {
    throw UnimplementedError();
  }

  @override
  Future refreshList(List<TodoModel> list) async {
    await api.updateList(list);
    notifyListeners();
  }

  @override
  Future updateItem(TodoModel item) async {
    await api.updateItem(item);
    notifyListeners();
  }

  @override
  int get totalItems => _offlineItems?.length ?? 0;
}
