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

  // copywith
  TodoModel copyWith({
    String? id,
    String? text,
    String? color,
    bool? done,
    String? importance,
    DateTime? deadline,
    DateTime? changedAt,
    DateTime? createdAt,
  }) {
    return TodoModel(
      id: id ?? this.id,
      text: text ?? this.text,
      color: color ?? this.color,
      done: done ?? this.done,
      importance: importance ?? this.importance,
      deadline: deadline ?? this.deadline,
      changedAt: changedAt ?? this.changedAt,
      createdAt: createdAt ?? this.createdAt,
    );
  }
}
