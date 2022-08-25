import 'package:hive/hive.dart';

part 'todo_model.g.dart';

@HiveType(typeId: 0)
class TodoModel extends HiveObject {
  @HiveField(0)
  late String id;
  @HiveField(1)
  late String text;
  @HiveField(2)
  String? color;
  @HiveField(3)
  late bool done;
  @HiveField(4)
  late String importance;
  @HiveField(5)
  DateTime? deadline;
  @HiveField(6)
  late DateTime changedAt;
  @HiveField(7)
  late DateTime createdAt;
  @HiveField(8)
  late String lastUpdatedBy;

  TodoModel({
    required this.importance,
    required this.id,
    required this.text,
    required this.done,
    required this.changedAt,
    required this.createdAt,
    required this.lastUpdatedBy,
    this.deadline,
    this.color,
  });

  TodoModel pasteFromOther(TodoModel model) {
    id = model.id;
    text = model.text;
    color = model.color;
    importance = model.importance;
    done = model.done;
    deadline = model.deadline;
    changedAt = model.changedAt;
    createdAt = model.createdAt;
    return this;
  }

  Map<String, dynamic> toJson() {
    var data = <String, dynamic>{
      "id": id,
      "text": text,
      "importance": importance,
      "done": done,
      "created_at": (createdAt.millisecondsSinceEpoch / 1000).round(),
      "changed_at": (changedAt.millisecondsSinceEpoch / 1000).round(),
      "last_updated_by": lastUpdatedBy,
    };
    if (deadline != null) {
      data["deadline"] = (deadline!.millisecondsSinceEpoch / 1000).round();
    }
    if (color != null) data["color"] = color;
    return data;
  }

  TodoModel.fromJson(Map<String, dynamic> map) {
    id = map["id"];
    text = map["text"];
    done = map["done"];
    importance = map["importance"];
    createdAt = DateTime.fromMillisecondsSinceEpoch(map["created_at"] * 1000);
    changedAt = DateTime.fromMillisecondsSinceEpoch(map["changed_at"] * 1000);
    lastUpdatedBy = map["last_updated_by"];

    if (map["deadline"] != null) {
      deadline = DateTime.fromMillisecondsSinceEpoch(map["deadline"] * 1000);
    }
    color = map["color"];
  }
}
