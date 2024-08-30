import 'dart:async';

/// A simple state management class that holds a value and provides a stream for updates.
///
/// This class allows you to manage a single piece of state and notify listeners
/// about changes to that state via a stream. It also provides a mechanism to
/// update the state and automatically notify all listeners.
class SimpleState<T> {
  /// Creates a [SimpleState] with the given initial state.
  ///
  /// The initial state is used to set the initial value of the state and is
  /// provided to the stream controller to emit the initial value.
  SimpleState(T initialState)
      : _value = initialState,
        _controller = StreamController<T>.broadcast() {
    /// Set the onCancel callback to properly dispose of the controller.
    _controller.onCancel = dispose;
  }

  /// The current value of the state.
  T _value;

  /// The stream controller used to manage and broadcast state changes.
  final StreamController<T> _controller;

  /// The current value of the state.
  ///
  /// This getter allows you to retrieve the current value of the state.
  T get value => _value;

  /// The stream that provides updates to the state.
  ///
  /// This getter provides access to the stream of state changes, which can
  /// be listened to by widgets or other components.
  Stream<T> get stream => _controller.stream;

  /// Sets a new value for the state and notifies listeners.
  ///
  /// This setter updates the state value and emits the new value to all
  /// listeners via the stream. It only updates the value and notifies listeners
  /// if the new value is different from the current value.
  set value(T newState) {
    if (_value != newState) {
      _value = newState;
      _controller.add(_value);
    }
  }

  /// Disposes of the stream controller when it is no longer needed.
  ///
  /// This method is called when the stream controller is canceled. It ensures
  /// that the stream controller is closed and no longer used.
  void dispose() {
    if (!_controller.isClosed) {
      _controller.close();
    }
  }
}
