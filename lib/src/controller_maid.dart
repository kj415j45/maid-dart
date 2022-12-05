/// [ControllerMaid] wrap a [_box] and holding it.
/// Provide a controller-like interface.
///
/// Maid will be spawned by [ControllerMaid.of] with an initial box.
/// You can ask her to [serve] the box to you, or [take] another box.
///
/// She will call you after taking something new if you request a [callMeOnTaken].
class ControllerMaid<Box> {
  Box _box;

  Box get box => serve();
  set box(Box box) => take(box);

  /// Serve the box that maid is holding.
  Box serve() => _box;

  /// Take another box then return the old box.
  Box take(Box box) {
    Box oldBox = _box;
    _box = box;
    for (var callRequest in _requests) {
      callRequest(oldBox, box);
    }
    return oldBox;
  }

  ControllerMaid._hold(this._box);

  /// Spawn with initial [box].
  /// By default, maid would not [vow] to secure the box forever.
  /// So it can be [take] by another box.
  factory ControllerMaid.of(Box box, [bool vow = false]) =>
      vow ? VowedControllerMaid._hold(box) : ControllerMaid._hold(box);

  final List<void Function(Box oldBox, Box newBox)> _requests = [];

  /// [request] is a function that takes two arguments,
  /// the old box and the new box.
  ///
  /// You can add as many requests as you like, they would be called
  /// after box being changed by the order of adding.
  void callMeOnTaken(void Function(Box oldBox, Box newBox) request) {
    _requests.add(request);
  }

  /// Cancel a previous [request] added by [callMeOnTaken].
  void cancelRequest(void Function(Box oldBox, Box newBox) request) {
    _requests.remove(request);
  }

  /// C# style operator overloading of [callMeOnTaken].
  ControllerMaid<Box> operator +(void Function(Box oldBox, Box newBox) request) {
    callMeOnTaken(request);
    return this;
  }

  /// C# style operator overloading of [cancelRequest].
  ControllerMaid<Box> operator -(void Function(Box oldBox, Box newBox) request) {
    cancelRequest(request);
    return this;
  }

  Box operator <=(Box box) => take(box);
}

/// A [VowedControllerMaid] is a [ControllerMaid] that vow to secure the box forever.
/// The box will never be [take] by another box.
/// Any trying will result a [BreakingVowException] without actually works.
class VowedControllerMaid<Box> extends ControllerMaid<Box> {
  VowedControllerMaid._hold(Box box) : super._hold(box);

  @override
  Box take(Box box) => throw BreakingVowException();

  @override
  void callMeOnTaken(void Function(Box oldBox, Box newBox) request) =>
      throw BreakingVowException();
}

class BreakingVowException implements Exception {
  final message = 'Maid has vowed to secure the box.';
}
