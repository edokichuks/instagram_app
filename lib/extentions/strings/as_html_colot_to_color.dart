import 'package:flutter/animation.dart';
import 'package:instagram_app/extentions/strings/remove_all.dart';


extension AsHtmlColorToColor on String {
  Color htmColorToColor() => Color(
    int.parse(
      removeAll(['0x', '#']).padLeft(8, 'ff'),
      radix: 16,
    )
  );
}
