import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:simple_state/simple_state.dart';

void main() {
  testWidgets('SimpleBuilder rebuilds on state change',
      (WidgetTester tester) async {
    final state = SimpleState<int>(0);

    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: SimpleBuilder<int>(
            state: state,
            builder: (context, value) {
              return Text('$value');
            },
          ),
        ),
      ),
    );

    // Verify initial state
    expect(find.text('0'), findsOneWidget);

    // Update state and verify
    state.value = 1;
    await tester.pump();
    expect(find.text('1'), findsOneWidget);
  });
}
