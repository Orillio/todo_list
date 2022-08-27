import 'package:freezed_annotation/freezed_annotation.dart';

part 'todo_model_domain.freezed.dart';

@freezed
class DomainTodoModel with _$TodoModelDomain {
  const factory DomainTodoModel({
    required String id,
    required String text,
    required String? color,
    required String importance,
    required bool done,
    required DateTime? deadline,
    required DateTime changedAt,
    required DateTime createdAt,
    required String lastUpdatedBy,
  }) = _TodoModelDomain;
}
