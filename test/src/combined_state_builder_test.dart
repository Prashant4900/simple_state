import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:simple_state/simple_state.dart';

void main() {
  testWidgets('CombinedStateBuilder rebuilds on any state change',
      (WidgetTester tester) async {
    final counter = SimpleState<int>(0);
    final isLoading = SimpleState<bool>(false);
    final username = SimpleState<String>('Guest');

    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: CombinedStateBuilder(
            stateStreams: [
              counter.stream,
              isLoading.stream,
              username.stream,
            ],
            builder: (context, values) {
              final count = values[0] as int?;
              final loading = values[1] as bool?;
              final user = values[2] as String?;
              return Column(
                children: [
                  Text('Count: $count'),
                  Text('Loading: $loading'),
                  Text('User: $user'),
                ],
              );
            },
          ),
        ),
      ),
    );

    // Verify initial states
    expect(find.text('Count: 0'), findsOneWidget);
    expect(find.text('Loading: false'), findsOneWidget);
    expect(find.text('User: Guest'), findsOneWidget);

    // Update states and verify
    counter.value = 1;
    isLoading.value = true;
    username.value = 'Prashant';
    await tester.pump();

    expect(find.text('Count: 1'), findsOneWidget);
    expect(find.text('Loading: true'), findsOneWidget);
    expect(find.text('User: Prashant'), findsOneWidget);
  });
}
