import 'dart:async';

import 'package:flutter/widgets.dart';

/// A widget that combines multiple streams and rebuilds
/// when any of them change.
///
/// The [CombinedStateBuilder] listens to multiple streams and rebuilds
/// the widget tree whenever any of the streams emit a new value.
/// It combines the latest values from all the streams into a list
/// and passes it to the [builder] function.
class CombinedStateBuilder extends StatelessWidget {
  /// Creates a [CombinedStateBuilder] with the given [stateStreams] and [builder] function.
  ///
  /// The [stateStreams] parameter is a list of streams that this widget
  /// will listen to for changes. The [builder] function is used to build
  /// the widget tree based on the combined values from all streams.
  const CombinedStateBuilder({
    required this.stateStreams,
    required this.builder,
    super.key,
  });

  /// The list of streams to be combined.
  ///
  /// The [CombinedStateBuilder] listens to these streams and combines
  /// their latest values into a single list that is passed to the [builder] function.
  final List<Stream<dynamic>> stateStreams;

  /// The function that builds the widget tree based on the combined values from all streams.
  ///
  /// The [builder] function is called with the current [BuildContext] and
  /// a list of the latest values from each stream. It returns the widget
  /// tree that should be displayed.
  final Widget Function(BuildContext, List<dynamic>) builder;

  @override
  Widget build(BuildContext context) {
    /// Use a [StreamBuilder] to listen to the combined stream and rebuild the widget.
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
  ///
  /// This method creates a new stream that emits a list of the latest values
  /// from each of the provided streams. Each time a stream emits a new value,
  /// the combined stream is updated with the new list of values.
  Stream<List<dynamic>> _combineStreams(List<Stream<dynamic>> streams) {
    return Stream<List<dynamic>>.multi((controller) {
      /// List to keep track of the latest values from each stream
      final latestValues = List<dynamic>.filled(streams.length, null);

      /// Function to update the latest value for a specific stream
      void updateValue(int index, dynamic value) {
        latestValues[index] = value;
        controller.add(List.from(latestValues));
      }

      /// List of stream subscriptions
      final subscriptions = <StreamSubscription<dynamic>>[];

      /// Subscribe to each stream and update the values accordingly
      for (var i = 0; i < streams.length; i++) {
        final subscription = streams[i].listen(
          (value) => updateValue(i, value),
          onError: (Object error) => controller.addError(error),
        );
        subscriptions.add(subscription);
      }

      /// Handle stream cancellation and dispose
      controller.onCancel = () {
        for (final subscription in subscriptions) {
          subscription.cancel();
        }
      };
    });
  }
}
