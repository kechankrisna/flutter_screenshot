import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'dart:async';
import 'package:flutter/services.dart';
import 'package:flutter_screenshot/flutter_screenshot.dart';
import 'dart:ui' as ui;
import 'dart:math';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool _isGenrated = false;
  List<ScreenshotController> screenshotControllers =
      List<ScreenshotController>.generate(5, (i) => ScreenshotController());
  List<Uint8List> _datas = [];


  ScreenshotController screenshotController = ScreenshotController();


  @override
  void initState() {
    super.initState();
  }

  //multi screenshot
  void _testMultiScreenshot() async {
    List<Uint8List> datas = await Future.wait(screenshotControllers
        .map((ScreenshotController screenshotController) async =>
            await screenshotController.captureAsUint8List(pixelRatio: 10))
        .toList());
    print(datas);
    setState(() {
      _datas = datas;
      _isGenrated = true;
    });
  }

  //single screenshot
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
        //multi-screenshot
        body: Container(
          alignment: Alignment.center,
          child: _isGenrated && _datas.length > 0
              ? ListView.builder(
              itemCount: _datas.length,
              itemBuilder: (_, index) {
                  return Image.memory(_datas[index]);
                })
              : ListView.builder(
                  itemCount: screenshotControllers.length,
                  itemBuilder: (_, index) {
                    return ScreenshotContainer(
                      controller: screenshotControllers[index],
                      child: Text("Sreenshot me now", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.blue),),
                    );
                  }),
         //single-screenshot
//          body: Container(
//            alignment: Alignment.center,
//            child: Column(
//              mainAxisAlignment: MainAxisAlignment.center,
//              children: <Widget>[
//                ScreenshotContainer(
//                  controller: screenshotController,
//                  child: Text("Sreenshot me now"),
//                ),
//
//
//                RaisedButton(
//                  onPressed: () {
//                    _testScreenshot();
//                  },
//                  child: Text("Pressed me"),
//                ),
//              ],
//            ),
//          ),

        ),
        floatingActionButton: RaisedButton(
          onPressed: () {
            _testMultiScreenshot();
          },
          child: Text("Pressed me"),
        ),
      ),
    );
  }
}
