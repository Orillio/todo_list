
class TodoModel {
  String id;
  String text;
  String? color;
  bool done;
  String importance;
  DateTime? deadline;
  DateTime changedAt;
  DateTime createdAt;

  TodoModel({
    required this.importance,
    required this.id,
    required this.text,
    required this.done,
    required this.changedAt,
    required this.createdAt,
    this.deadline,
    this.color,
  });
}
