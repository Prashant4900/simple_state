import 'package:flutter/widgets.dart';

import 'simple_state.dart';

/// A widget that rebuilds when the state value changes.
class SimpleBuilder<T> extends StatelessWidget {
  const SimpleBuilder({
    required this.state,
    required this.builder,
    super.key,
  });

  final SimpleState<T> state;
  final Widget Function(BuildContext, T) builder;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<T>(
      stream: state.stream,
      initialData: state.value,
      builder: (context, snapshot) => builder(context, snapshot.data as T),
    );
  }
}
