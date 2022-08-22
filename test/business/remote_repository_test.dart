import 'package:flutter_test/flutter_test.dart';
import 'package:todo_list/business/api/back_api.dart';
import 'package:todo_list/business/repository/remote_tasks_repository.dart';
import 'package:todo_list/models/todo_model.dart';
import 'package:uuid/uuid.dart';

void main() {
  late RemoteTasksRepository repository;
  final testItem = TodoModel(
    importance: "low",
    id: const Uuid().v4(),
    text: "Example for test",
    done: true,
    changedAt: DateTime(2022),
    createdAt: DateTime(2022),
    lastUpdatedBy: "1",
  );

  setUp(() {
    repository = RemoteTasksRepository(api: BackApi());
  });

  test('add item to server', () async {
    await repository.addItem(testItem);

    var serverItem = (await repository.getTodoList())
        .firstWhere((element) => element.id == testItem.id);
    expect(testItem.id, serverItem.id);
  });
  test("delete item", () async {
    await repository.deleteItem(testItem);
    var result = (await repository.getTodoList()).any((e) => e.id == testItem.id);
    expect(result, false);
  });
}
