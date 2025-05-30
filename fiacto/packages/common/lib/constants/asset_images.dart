// ignore_for_file: constant_identifier_names, unused_element

import 'dart:async';

import 'package:common/utils/utils.dart';
import 'package:flutter/material.dart';

enum AssetImages {
  splash,
  ;

  // ignore: unused_element_parameter
  const AssetImages([this.format = AssetImageFormat.png]);
  final AssetImageFormat format;

  static Future<void> preloadLogoBackground() =>
      preloadImage(AssetImages.splash());
}

enum AssetImageFormat {
  png,
  jpg,
}

extension AssetImagesX on AssetImages {
  static const String _basePath = 'assets/images';

  String call() => '$_basePath/$name.${format.name}';
}

Future<void> preloadImage(String asset) async {
  late ImageStreamListener listener;

  final completer = Completer<void>();
  final ImageStream imageStream =
      AssetImage(asset).resolve(ImageConfiguration.empty);

  listener = ImageStreamListener(
    (imageInfo, synchronousCall) {
      imageStream.removeListener(listener);
      completer.complete();
    },
    onError: (exception, stackTrace) {
      imageStream.removeListener(listener);
      completer.completeError(exception);
    },
  );

  imageStream.addListener(listener);

  try {
    await completer.future;
  } catch (e) {
    $debugLog(e, tag: 'preloadImage');
  }
}
