import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'dart:async';
import 'package:flutter/services.dart';
import 'package:flutter_screenshot/flutter_screenshot.dart';
import 'dart:ui' as ui;

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

  ScreenshotController screenshotController = ScreenshotController();
  @override
  void initState() {
    super.initState();
  }

  void _testScreenshot() {
    
    screenshotController.captureAsFile().then((File file){
      print(file);
    });

    screenshotController.captureAsByteData().then((ByteData byteData){
      print(byteData);
    });

    screenshotController.captureAsUint8List().then((Uint8List uint8List){
      print(Uint8List);
    });

    screenshotController.captureAsUiImage().then((res) {
      ui.Image image = res;
      print(image);
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Plugin example app'),
        ),
        body: Container(
          alignment: Alignment.center,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              ScreenshotContainer(
                controller: screenshotController,
                child: Text("Sreenshot me now"),
              ),
              
              
              RaisedButton(
                onPressed: () {
                  _testScreenshot();
                },
                child: Text("Pressed me"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
