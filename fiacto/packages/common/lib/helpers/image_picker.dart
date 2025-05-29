import 'dart:io';

import 'package:common/common.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:image_picker/image_picker.dart';

typedef PickerSource = ImageSource;

/// Using [HttpFile] to avoid dart:io dependency.
class ImagePickerHelper {
  ImagePickerHelper([ImagePicker? imagePicker])
      : _imagePicker = imagePicker ?? ImagePicker();

  final ImagePicker _imagePicker;

  Future<HttpFile?> getImageFromCamera([CameraDevice? camera]) =>
      getImage(PickerSource.camera, camera: camera);

  Future<HttpFile?> getImageFromGallery() => getImage(PickerSource.gallery);

  Future<HttpFile?> getImage(
    PickerSource source, {
    CameraDevice? camera,
  }) async {
    try {
      final file = await _imagePicker.pickImage(
        source: source,
        preferredCameraDevice: camera ?? CameraDevice.front,
        imageQuality: 60, //*THROWS ERROR*
      );
      if (file != null) {
        return HttpFile(
          path: file.path,
          name: file.name,
          bytes: await file.readAsBytes(),
        );
      }
      return null;
    } catch (e) {
      return null;
    }
  }
}

extension CachedImageFromUrlString on String {
  Future<HttpFile?> getCachedFile({Map<String, String>? headers}) async {
    try {
      final file = await DefaultCacheManager().getSingleFile(
        this,
        headers: headers,
      );
      return HttpFile(
        path: file.path,
        name: file.basename,
        bytes: await file.readAsBytes(),
      );
    } catch (e) {
      return null;
    }
  }
}

extension Uint8ListToMemoryImage on Uint8List {
  /// Convert bytes to memory image
  MemoryImage? memoryImage({double scale = 1.0}) =>
      isEmpty ? null : MemoryImage(this, scale: scale);
}

extension FileHelper on File {
  /// Convert bytes to memory image
  Future<HttpFile>? toHttpFile() async => HttpFile(
        path: path,
        name: path.split('/').last,
        bytes: await readAsBytes(),
      );
}
