import 'package:maid/maid.dart';
import 'package:test/test.dart';

void main() {
  group('Singleton Maid', () {
    var maidOfInt = Maids.singleton<int>(42);
    var maidOfInt_ = Maids.singleton<int>();
    var maidOfNullableInt = Maids.singleton<int?>();

    test('Init with null on non-nullable type', () {
      try {
        Maids.singleton<String>();
      } catch (e) {
        expect(e is TypeError, isTrue);
      }
    });

    test('Direct call to maid', () {
      expect(Maids.singleton<int>().serve() == 42, isTrue);
      expect(Maids.singleton<int?>().serve() == null, isTrue);
    });

    test('Same type parameter should be same Maid', () {
      expect(maidOfInt == maidOfInt_, isTrue);
      expect(maidOfInt == Maids.singleton<int>(), isTrue);
    });

    test('Different type parameter should be different Maid', () {
      expect(maidOfInt != maidOfNullableInt, isTrue);
      expect(maidOfInt != Maids.singleton<double>(3.14), isTrue);
    });
  });
}
