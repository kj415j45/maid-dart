import 'package:maid/maid.dart';

void main() {
  // General [Maids.control] usage, create a [ControllerMaid] with [42] in box.
  var maid = Maids.control(42)
    ..callMeOnTaken((oldBox, newBox) async {
      //async callback
      await Future.delayed(const Duration(seconds: 1));
      print('[async] I got a new value: $newBox, the old one is: $oldBox');
    });

  delegate(oldBox, newBox) {
    //sync callback
    print('I got a new value: $newBox, the old one is: $oldBox');
  }

  maid += delegate; //C# like delegate

  // Ask maid to serve the box
  print(maid.serve()); // 42

  // Ask maid to take another one
  // then callMeOnTake will be called
  print(maid.take(233)); //42

  // Maid is serving [233] now
  print(maid.serve()); // 233
}
