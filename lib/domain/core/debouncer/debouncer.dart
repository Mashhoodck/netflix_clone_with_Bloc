import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:flutter/animation.dart';

class Debouncer {
  final int milliSeconds;
  VoidCallback? action;
  Timer? _timer;

  Debouncer({required this.milliSeconds});

  run(VoidCallback action) {
    if (_timer != null) {
      _timer!.cancel();
    }

    _timer = Timer(Duration(milliseconds: milliSeconds), action);
  }
}
