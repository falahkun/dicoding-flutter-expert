import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:home/home.dart';

void main() {

  setUp(() {
    TestWidgetsFlutterBinding.ensureInitialized();
  });
  
  Future<void> _widget(WidgetTester widgetTester) async {
    return await widgetTester.pumpWidget(MaterialApp(
      home: MediaQuery(
        data: const MediaQueryData(),
        child: AboutPage(),
      ),
    ));
  }
  
  testWidgets('render about_page_test.dart', (widgetTester) async {
    await _widget(widgetTester);
    expect(find.byType(Text), findsOneWidget);
    expect(find.byType(IconButton), findsOneWidget);
  });
}
