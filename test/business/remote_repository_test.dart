import 'package:flutter_test/flutter_test.dart';
import 'package:todo_list/business/api/api.dart';
import 'package:mockito/annotations.dart';

@GenerateMocks([Api])
import 'remote_repository_test.mocks.dart';

void main() {
  late Api api;

  setUp(() {
    api = MockApi();
  });
}
