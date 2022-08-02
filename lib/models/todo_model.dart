
class TodoModel {
  late String id;
  late String text;
  String? color;
  late bool done;
  late String importance;
  DateTime? deadline;
  late DateTime changedAt;
  late DateTime createdAt;
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
  TodoModel changeFields({
    String? id,
    String? text,
    String? color,
    String? importance,
    bool? done,
    DateTime? deadline,
    DateTime? changedAt,
    DateTime? createdAt,
  }) {
    this.id = id ?? this.id;
    this.text = text ?? this.text;
    this.color = color ?? this.color;
    this.importance = importance ?? this.importance;
    this.done = done ?? this.done;
    this.deadline = deadline ?? this.deadline;
    this.changedAt = changedAt ?? this.changedAt;
    this.createdAt = createdAt ?? this.createdAt;
    return this;
  }

  TodoModel pasteFromOther({
    String? id,
    String? text,
    String? color,
    String? importance,
    bool? done,
    DateTime? deadline,
    DateTime? changedAt,
    DateTime? createdAt,
  }) {
    this.id = id ?? this.id;
    this.text = text ?? this.text;
    this.color = color ?? this.color;
    this.importance = importance ?? this.importance;
    this.done = done ?? this.done;
    this.deadline = deadline ?? this.deadline;
    this.changedAt = changedAt ?? this.changedAt;
    this.createdAt = createdAt ?? this.createdAt;
    return this;
  }


  Map<String, dynamic> toMap() {
    var data = <String, dynamic>{
      "id": id,
      "text": text,
      "importance": importance,
      "done": done,
      "created_at": (createdAt.millisecondsSinceEpoch / 1000).round(),
      "changed_at": (changedAt.millisecondsSinceEpoch / 1000).round(),
      "last_updated_by": lastUpdatedBy,
    };
    if(deadline != null) data["deadline"] = (deadline!.millisecondsSinceEpoch / 1000).round();
    if(color != null) data["color"] = color;
    return data;
  }
  TodoModel.fromMap(dynamic map) {
    id = map["id"];
    text = map["text"];
    done = map["done"];
    importance = map["importance"];
    createdAt = DateTime.fromMillisecondsSinceEpoch(map["created_at"] * 1000);
    changedAt = DateTime.fromMillisecondsSinceEpoch(map["changed_at"] * 1000);
    lastUpdatedBy = map["last_updated_by"];

    if(map["deadline"] != null) deadline = DateTime.fromMillisecondsSinceEpoch(map["deadline"] * 1000);
    color = map["color"];


  }
}
