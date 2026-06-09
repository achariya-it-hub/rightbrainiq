import 'package:flutter_test/flutter_test.dart';
import 'package:rightbrainiq/main.dart';

void main() {
  testWidgets('App launches with splash screen', (WidgetTester tester) async {
    await tester.pumpWidget(const RightBrainIQApp());
    expect(find.text('RightBrainIQ'), findsOneWidget);
  });
}
