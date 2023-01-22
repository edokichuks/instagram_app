

import 'package:flutter/material.dart';

extension DismissKey on Widget {
  void dismissKeyboard() => FocusManager.instance.primaryFocus?.unfocus();
}
