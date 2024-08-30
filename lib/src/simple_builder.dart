import 'package:flutter/widgets.dart';
import 'package:simple_state/src/simple_state.dart';

/// A widget that rebuilds when the state value changes.
///
/// The [SimpleBuilder] widget listens to changes in a [SimpleState] and rebuilds
/// itself whenever the state value updates. It uses a [StreamBuilder] to listen
/// to the state stream and trigger rebuilds with the latest state value.
class SimpleBuilder<T> extends StatelessWidget {
  /// Creates a [SimpleBuilder] with the given [state] and [builder] function.
  ///
  /// The [state] parameter is the instance of [SimpleState] that this widget
  /// will listen to for state changes. The [builder] function is used to build
  /// the widget tree based on the current state value.
  const SimpleBuilder({
    required this.state,
    required this.builder,
    super.key,
  });

  /// The [SimpleState] instance that this widget listens to.
  ///
  /// The [SimpleBuilder] uses this [state] to listen for updates and rebuild
  /// the widget tree when the state changes.
  final SimpleState<T> state;

  /// The function that builds the widget tree based on the state value.
  ///
  /// The [builder] function is called with the current [BuildContext] and
  /// the latest state value. It returns the widget tree that should be displayed.
  final Widget Function(BuildContext, T) builder;

  @override
  Widget build(BuildContext context) {
    /// Use a [StreamBuilder] to listen to state changes and rebuild the widget.
    return StreamBuilder<T>(
      stream: state.stream,
      initialData: state.value,
      builder: (context, snapshot) {
        /// Call the builder function with the latest state value.
        return builder(context, snapshot.data as T);
      },
    );
  }
}
