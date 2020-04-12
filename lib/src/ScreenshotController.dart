import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:ui' as ui;

class ScreenshotController {

  GlobalKey containerKey;

  ScreenshotController({GlobalKey key}){
    containerKey = key ?? GlobalKey();
  }

  Future<File> captureAsFile(
      {String path = "",
      double pixelRatio: 1.0,
      Duration delay: const Duration(milliseconds: 20)}) {
    //DElay is required. See Issue https://github.com/flutter/flutter/issues/22308
    return Future.delayed(delay, () async {
      try {
        RenderRepaintBoundary boundary =
            this.containerKey.currentContext.findRenderObject();
        ui.Image image = await boundary.toImage(pixelRatio: pixelRatio);
        ByteData byteData =
            await image.toByteData(format: ui.ImageByteFormat.png);
        Uint8List pngBytes = byteData.buffer.asUint8List();
        if (path == "") {
          final directory = (await getApplicationDocumentsDirectory()).path;
          String fileName = DateTime.now().toIso8601String();
          path = '$directory/$fileName.png';
        }
        File imgFile = File(path);
        await imgFile.writeAsBytes(pngBytes);
        return imgFile;
      } catch (Exception) {
        throw (Exception);
      }
    });
  }

  Future<ui.Image> captureAsUiImage(
      {double pixelRatio: 1,
      Duration delay: const Duration(milliseconds: 20)}) {
    //Delay is required. See Issue https://github.com/flutter/flutter/issues/22308
    return Future.delayed(delay, () async {
      try {
        RenderRepaintBoundary boundary =
            this.containerKey.currentContext.findRenderObject();
        return await boundary.toImage(pixelRatio: pixelRatio);
      } catch (Exception) {
        throw (Exception);
      }
    });
  }

  Future<ByteData> captureAsByteData(
      {double pixelRatio: 1,
      Duration delay: const Duration(milliseconds: 20)}) {
    //Delay is required. See Issue https://github.com/flutter/flutter/issues/22308
    return Future.delayed(delay, () async {
      try {
        RenderRepaintBoundary boundary =
            this.containerKey.currentContext.findRenderObject();
        ui.Image image = await boundary.toImage(pixelRatio: pixelRatio);
        ByteData byteData =
            await image.toByteData(format: ui.ImageByteFormat.png);
        return byteData;
      } catch (Exception) {
        throw (Exception);
      }
    });
  }

  Future<Uint8List> captureAsUint8List(
      {double pixelRatio: 1,
      Duration delay: const Duration(milliseconds: 20)}) {
    //Delay is required. See Issue https://github.com/flutter/flutter/issues/22308
    return Future.delayed(delay, () async {
      try {
        RenderRepaintBoundary boundary =
            this.containerKey.currentContext.findRenderObject();
        ui.Image image = await boundary.toImage(pixelRatio: pixelRatio);
        ByteData byteData =await image.toByteData(format: ui.ImageByteFormat.png);
        Uint8List pngBytes = byteData.buffer.asUint8List();
        return pngBytes;
      } catch (Exception) {
        throw (Exception);
      }
    });
  }
}
