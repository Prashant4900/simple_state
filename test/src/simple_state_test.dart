// ignore_for_file: cascade_invocations

import 'package:flutter_test/flutter_test.dart';
import 'package:simple_state/simple_state.dart';

void main() {
  group('SimpleState', () {
    test('initial value should be correct', () {
      final state = SimpleState<int>(0);
      expect(state.value, 0);
    });

    test('should update value correctly', () {
      final state = SimpleState<int>(0);
      state.value = 1;
      expect(state.value, 1);
    });

    test('should emit new value on change', () async {
      final state = SimpleState<int>(0);
      final values = <int>[0];

      // Listen to the stream and add values to the list
      final subscription = state.stream.listen(values.add);

      // Update the state values
      state.value = 1;
      state.value = 2;

      // Give the stream some time to emit values
      await Future<void>.delayed(Duration.zero);

      // Cancel the subscription
      await subscription.cancel();

      // Verify the emitted values
      expect(values, [0, 1, 2]);
    });
  });
}
