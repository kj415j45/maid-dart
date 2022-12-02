import 'dart:io';

import 'package:maid/maid.dart';
import 'package:test/test.dart';

void main() {
  group('Controller Maid', () {
    var maid = Maids.control(42);

    var fileTaken = false;
    var maidOfFile = Maids.control(File('README.md'))
      ..callMeOnTaken((oldBox, newBox) {
        fileTaken = true;
      });

    test('Serve box', () {
      expect(maid.box == 42, isTrue);
      expect(maid.serve() == 42, isTrue);
    });

    test('Take another box', () {
      expect(maid.take(114514) == 42, isTrue);
      expect(maid.box == 114514, isTrue);
      maid.box = 42;
      expect(maid.serve() == 42, isTrue);
    });

    test('Call request', () {
      expect(fileTaken, isFalse);
      maidOfFile.take(File('pubspec.yml'));
      expect(fileTaken, isTrue);
    });
  });

  group('Vowed Controller Maid', () {
    var vowedMaid = Maids.control(233, true);

    test('Breaking vow', () {
      try {
        vowedMaid.callMeOnTaken((oldBox, newBox) {});
      } catch (e) {
        expect(e is BreakingVowException, isTrue);
      }

      try {
        vowedMaid.take(114514);
      } catch (e) {
        expect(e is BreakingVowException, isTrue);
      }
      expect(vowedMaid.serve() == 233, isTrue);
    });
  });
}
