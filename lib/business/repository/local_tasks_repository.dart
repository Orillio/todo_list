import 'package:hive_flutter/hive_flutter.dart';
import 'package:todo_list/business/repository/tasks_repository.dart';
import 'package:todo_list/models/todo_model.dart';

class LocalTasksRepository implements TasksRepository {
  late Box<TodoModel> _todoBox;
  late Box<int> _revisionBox;

  LocalTasksRepository() {
    _todoBox = Hive.box<TodoModel>("todoBox");
    _revisionBox = Hive.box<int>("revision");
  }

  void setRevision(int newRevision) {
    _revisionBox.put("revision", newRevision);
  }

  @override
  Future addItem(TodoModel item) async {
    _todoBox.add(item);
    _revisionBox.put("revision", await getRevision() + 1);
  }

  @override
  Future deleteItem(TodoModel item) async {
    _todoBox.values.firstWhere((element) => element.id == item.id).delete();
    _revisionBox.put("revision", await getRevision() + 1);
  }

  @override
  Future<int> getRevision() async {
    return _revisionBox.get("revision") ?? -1;
  }

  @override
  Future<List<TodoModel>> getTodoList() async {
    var list = _todoBox.values.toList();
    return list;
  }

  @override
  Future refreshList(List<TodoModel> list) async {
    await _todoBox.clear();
    await _todoBox.addAll(list);
    await _revisionBox.put("revision", await getRevision() + 1);
  }

  @override
  Future updateItem(TodoModel item) async {
    var model = _todoBox.values.firstWhere((element) => element.id == item.id);

    model.pasteFromOther(item).save();
    _revisionBox.put("revision", await getRevision() + 1);
  }
}
