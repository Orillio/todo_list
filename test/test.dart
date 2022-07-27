import 'package:flutter_test/flutter_test.dart';
import 'package:todo_list/business/api/back_api.dart';

void main() {
  late BackApi api;

  setUp(() {
    api = BackApi();
  });

  test("alright", () async {
    int revision = await api.getUpToDateRevision();
    expect(revision, isPositive);
  });
}