import 'dart:async';

import 'package:flutter/widgets.dart';

/// A widget that combines multiple streams and rebuilds
/// when any of them change.
class CombinedStateBuilder extends StatelessWidget {
  const CombinedStateBuilder({
    required this.stateStreams,
    required this.builder,
    super.key,
  });

  final List<Stream<dynamic>> stateStreams;
  final Widget Function(BuildContext, List<dynamic>) builder;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<List<dynamic>>(
      stream: _combineStreams(stateStreams),
      initialData: List<dynamic>.filled(stateStreams.length, null),
      builder: (context, snapshot) {
        final values = snapshot.data!;
        return builder(context, values);
      },
    );
  }

  /// Combines multiple streams into a single stream that emits lists of values.
  Stream<List<dynamic>> _combineStreams(List<Stream<dynamic>> streams) {
    return Stream<List<dynamic>>.multi((controller) {
      // List to keep track of the latest values from each stream
      final latestValues = List<dynamic>.filled(streams.length, null);

      // Function to update the latest value for a specific stream
      void updateValue(int index, dynamic value) {
        latestValues[index] = value;
        controller.add(List.from(latestValues));
      }

      // List of stream subscriptions
      final subscriptions = <StreamSubscription<dynamic>>[];

      // Subscribe to each stream and update the values accordingly
      for (var i = 0; i < streams.length; i++) {
        final subscription = streams[i].listen(
          (value) => updateValue(i, value),
          onError: (Object error) => controller.addError(error),
        );
        subscriptions.add(subscription);
      }

      // Handle stream cancellation and dispose
      controller.onCancel = () {
        for (final subscription in subscriptions) {
          subscription.cancel();
        }
      };
    });
  }
}
