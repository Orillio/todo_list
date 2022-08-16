import 'package:todo_list/models/todo_model.dart';
import 'package:uuid/uuid.dart';
import 'tasks_repository.dart';

class FakeTodoProvider implements TasksRepository {
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
          importance: i % 3 == 0
              ? "low"
              : i % 3 == 1
                  ? "basic"
                  : "high",
          lastUpdatedBy: const Uuid().v4(),
        ),
    ];
    _items[0].deadline = DateTime.now();
    _items[3].deadline = DateTime.now();
    _items[5].deadline = DateTime.now();
  }

  @override
  Future addItem(TodoModel item) async {
    _items.add(item);
  }

  @override
  Future deleteItem(TodoModel item) async {
    await Future.delayed(const Duration(milliseconds: 200));
    _items.remove(item);
  }

  @override
  Future<List<TodoModel>> getTodoList() async {
    await Future.delayed(const Duration(seconds: 2));
    return _items;
  }

  @override
  Future refreshList(List<TodoModel> list) async {
    _items.clear();
    _items.addAll(list);
  }

  @override
  Future updateItem(TodoModel item) async {
    await Future.delayed(const Duration(milliseconds: 150));
    var model = _items.where((i) => i.id == item.id).first;
    model = item;
    item = model;
  }

  @override
  Future<int> getRevision() async {
    return 0;
  }
}
