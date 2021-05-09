import 'package:flutter_test/flutter_test.dart';
import 'package:pings/main.dart';

void main() {
  testWidgets(
    'Home displays PING!',
    (WidgetTester tester) async {
      await tester.pumpWidget(const PingsApp());
      final pingFinder = find.text('PING!');
      expect(pingFinder, findsOneWidget);
    },
  );
}
