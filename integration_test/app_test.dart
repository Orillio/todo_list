import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:todo_list/business/utils/flavors_service.dart';
import 'package:todo_list/main_common.dart' as app;

void main() {
  group("App Testing", () {
    IntegrationTestWidgetsFlutterBinding.ensureInitialized();

    testWidgets("add new item", (tester) async {
      await app.noZonedGuardedMain(config: FlavorConfig(true));
      await tester.pumpAndSettle();

      var button = find.byIcon(Icons.add);
      await tester.tap(button);
      await tester.pumpAndSettle();

      expect(find.byIcon(Icons.close), findsOneWidget);
      expect(find.text("СОХРАНИТЬ"), findsOneWidget);
      expect(find.text("Что нужно сделать?"), findsOneWidget);
      expect(find.text("Важность"), findsOneWidget);
      expect(find.text("Сделать до"), findsOneWidget);

      await tester.enterText(
          find.byType(TextField), "Integration test example");
      await tester.pump();

      expect(find.text("Integration test example"), findsOneWidget);

      await tester.tap(find.text("Важность"));
      await tester.pumpAndSettle();
      await tester.tap(find.text("Высокий").first);
      await tester.pumpAndSettle();

      expect(find.text("Высокий"), findsOneWidget);

      await tester.tap(find.byType(Switch));
      await tester.pumpAndSettle();
      await tester.tap(find.text("ОК"));
      await tester.pumpAndSettle();

      expect(
          find.byKey(const ValueKey("deadline_date_switch")), findsOneWidget);

      await tester.tap(find.text("СОХРАНИТЬ"));
      await tester.pumpAndSettle();

      expect(find.text("Integration test example"), findsWidgets);
    });
  });
}
