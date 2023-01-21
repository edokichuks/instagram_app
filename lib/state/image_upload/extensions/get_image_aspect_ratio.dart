import 'package:flutter/material.dart' as material
    show Image, ImageConfiguration, ImageStreamListener;
import 'dart:async' show Completer;

extension GetImageAspectRation on material.Image {
  Future<double> getAspectRatio() async {
    final completer = Completer<double>();

    image
        .resolve(const material.ImageConfiguration())
        .addListener(material.ImageStreamListener(
      (image, synchronousCall) {
        final aspectRatio = image.image.width / image.image.height;

        image.image.dispose();
        completer.complete(aspectRatio);
      },
    ));
    return completer.future;
  }
}
