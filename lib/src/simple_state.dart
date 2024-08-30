import 'dart:async';

class SimpleState<T> {
  SimpleState(T initialState)
      : _value = initialState,
        _controller = StreamController<T>.broadcast() {
    _controller.onCancel = _dispose;
  }

  T _value;
  final StreamController<T> _controller;

  T get value => _value;

  Stream<T> get stream => _controller.stream;

  set value(T newState) {
    if (_value != newState) {
      _value = newState;
      _controller.add(_value);
    }
  }

  void _dispose() {
    if (!_controller.isClosed) {
      _controller.close();
    }
  }
}

// class SimpleBuilder<T> extends StatelessWidget {
//   const SimpleBuilder({
//     required this.state,
//     required this.builder,
//     super.key,
//   });

//   final SimpleState<T> state;
//   final Widget Function(BuildContext, T) builder;

//   @override
//   Widget build(BuildContext context) {
//     return StreamBuilder<T>(
//       stream: state.stream,
//       initialData: state.value,
//       builder: (context, snapshot) => builder(context, snapshot.data as T),
//     );
//   }
// }

// class CombinedStateBuilder extends StatelessWidget {
//   const CombinedStateBuilder({
//     required this.stateStreams,
//     required this.builder,
//     super.key,
//   });

//   final List<Stream<dynamic>> stateStreams;
//   final Widget Function(BuildContext, List<dynamic>) builder;

//   @override
//   Widget build(BuildContext context) {
//     return StreamBuilder<List<dynamic>>(
//       stream: _combineStreams(stateStreams),
//       initialData: List<dynamic>.filled(stateStreams.length, null),
//       builder: (context, snapshot) {
//         final values = snapshot.data!;
//         return builder(context, values);
//       },
//     );
//   }

//   Stream<List<dynamic>> _combineStreams(List<Stream<dynamic>> streams) {
//     return Stream<List<dynamic>>.multi((controller) {
//       // List to keep track of the latest values from each stream
//       List<dynamic> latestValues = List<dynamic>.filled(streams.length, null);

//       // Function to update the latest value for a specific stream
//       void updateValue(int index, dynamic value) {
//         latestValues[index] = value;
//         controller.add(List.from(latestValues));
//       }

//       // List of stream subscriptions
//       List<StreamSubscription<dynamic>> subscriptions = [];

//       // Subscribe to each stream and update the values accordingly
//       for (int i = 0; i < streams.length; i++) {
//         final subscription = streams[i].listen(
//           (value) => updateValue(i, value),
//           onError: (error) => controller.addError(error),
//         );
//         subscriptions.add(subscription);
//       }

//       // Handle stream cancellation and dispose
//       controller.onCancel = () {
//         for (var subscription in subscriptions) {
//           subscription.cancel();
//         }
//       };
//     });
//   }
// }
