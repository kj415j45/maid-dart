# Maid

Maids handle your chores.

## Features

- [ControllerMaid] works like other controller but lighter and focus on easy-access.
- [SingletonMaid] provides an noninvasive way to create singleton for other class.
- ...More maids are coming soon :tm:

## Getting started

Add `maid` to your `pubspec.yaml`.
```sh
dart pub add maid
```

Include it in your code.
```dart
import 'package:maid/maid.dart';
```

## Usage

```dart
var maid = Maids.control(42);
maid.serve(); //42
maid.take(233); //42
maid.serve() //233
```
For more usage, see [examples](example/).
