import 'package:flutter/foundation.dart' show immutable;
import 'package:flutter/material.dart';
import 'package:instagram_app/extentions/strings/as_html_colot_to_color.dart';

@immutable
class AppColors {
  static final loginButtonColor = '#cfc9c2'.htmColorToColor();
  static const logginButtonTextColor = Colors.black;
  static final googleColor = '#4285f4'.htmColorToColor();
  static final facebookColor = '#3b5998'.htmColorToColor();

  const AppColors._();
}
