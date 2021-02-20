// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility that Flutter provides. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

void main() {
  print(setupserialkey("03Y1FE0A9JKY6R2FA37J052F64"));
  print(setupserialkey("03Y1FE0A9JKY6R2FA37J052F64"));

  // testWidgets('Counter increments smoke test', (WidgetTester tester) async {
  //   // Build our app and trigger a frame.
  //
  //
  //   await tester.pumpWidget(MyApp());
  //
  //   // Verify that our counter starts at 0.
  //   expect(find.text('0'), findsOneWidget);
  //   expect(find.text('1'), findsNothing);
  //
  //   // Tap the '+' icon and trigger a frame.
  //   await tester.tap(find.byIcon(Icons.add));
  //   await tester.pump();
  //
  //   // Verify that our counter has incremented.
  //   expect(find.text('0'), findsNothing);
  //   expect(find.text('1'), findsOneWidget);
  // });
}

String setupserialkey(String serialkey) {
  var result = "";
  var count = 0;
  for (int i = 1; i < serialkey.length; i++) {
    if (i % 4 == 0) {
      count = i;
      result += serialkey.substring(i - 4, i) + "-";
    } else if (serialkey.length - 1 == i) {
      result +=
          serialkey.substring(count, serialkey.length );
    }
  }
  return result;
}
