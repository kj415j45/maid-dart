import 'controller_maid.dart';

/// [SingletonMaid.of] with type parameter can easily create a [VowedControllerMaid] with singleton behavior.
/// Which means you can not replace the box that Maid holding with another one.
class SingletonMaid {
  SingletonMaid._(); // coverage:ignore-line

  static final Map<Type, VowedControllerMaid> _maids = {};

  /// Do NOT init without parameter on non-nullable [T], as it will result a runtime [TypeError].
  ///
  /// It is possible to create a box with `T?`, so the box can be [Null].
  /// But be careful, nullable type is different from non-nullable type.
  /// ```dart
  /// print(SingletonMaid.of<int?>(42) == SingletonMaid.of<int>(42)); // false
  /// ```
  static VowedControllerMaid<T> of<T>([T? box]) =>
      (_maids[T] ??= ControllerMaid<T>.of(box as T, true) as VowedControllerMaid<T>) as VowedControllerMaid<T>;
}
