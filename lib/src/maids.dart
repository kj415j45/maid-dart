import 'controller_maid.dart';
import 'singleton_maid.dart';

class Maids {
  Maids._(); // coverage:ignore-line
  static ControllerMaid<T> control<T>(T box, [bool vow = false]) => ControllerMaid<T>.of(box, vow);
  static VowedControllerMaid<T> singleton<T>([T? box]) => SingletonMaid.of<T>(box);
}
