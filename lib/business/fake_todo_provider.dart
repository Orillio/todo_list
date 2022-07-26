import 'package:flutter/material.dart';
import 'package:todo_list/models/todo_model.dart';
import 'package:uuid/uuid.dart';
import 'i_todo_provider.dart';

class FakeTodoProvider with ChangeNotifier implements ITodoProvider {

  late final List<TodoModel> _items;

  FakeTodoProvider() {
    var now = DateTime.now();
    _items = [
      for (int i = 0; i < 20; i++)
        TodoModel(
          id: const Uuid().v4(),
          text: 'Купить $i что то.',
          done: i % 2 == 0,
          createdAt: now,
          changedAt: now,
          importance: i % 3 == 0 ? "low" : i % 3 == 1 ? "basic" : "high",
        ),
    ];
    _items[0].deadline = DateTime.now();
    _items[3].deadline = DateTime.now();
    _items[5].deadline = DateTime.now();
  }


  @override
  Future addItem(TodoModel item) async {
    _items.add(item);
    notifyListeners();
  }

  @override
  Future deleteItem(TodoModel item) async {
    _items.remove(item);
    notifyListeners();
  }

  @override
  Future<TodoModel> getConcreteItem(String id) async {
    return _items.firstWhere((item) => item.id == id);
  }

  @override
  Future<List<TodoModel>> getItemsFromNetwork() async {
    return _items;
  }

  @override
  Future<List<TodoModel>> getOfflineItems() async {
    return _items;
  }

  @override
  Future refreshList(List<TodoModel> list) async {
    _items.clear();
    _items.addAll(list);
    notifyListeners();
  }

  @override
  Future updateItem(TodoModel item) async {
    _items.removeWhere((i) => i.id == item.id);
    _items.add(item);
    notifyListeners();
  }
}