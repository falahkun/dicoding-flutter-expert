import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:home/src/presentation/fragment/fragment_list.dart';

void main() {
  group('test widget', () {
    testWidgets('find text widget', (widgetTester) async {
      await widgetTester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: FragmentList<int>(
              list: [1],
              builder: (_, value) => Container(
                constraints: BoxConstraints(
                  maxHeight: 200,
                  maxWidth: 200,
                ),
                child: Text('$value'),
              ),
            ),
          ),
        ),
      );

      expect(find.byType(Text), findsOneWidget);
    });
  });
}
