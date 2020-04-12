# flutter_screenshot

Flutter screenshot originally from screenshot package by extend more methods.

## Getting Started

```
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

```

```
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
        )
```


```
  bool _isGenrated = false;
  List<ScreenshotController> screenshotControllers =
      List<ScreenshotController>.generate(5, (i) => ScreenshotController());
  List<Uint8List> _datas = [];

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
```

```
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
    floatingActionButton: RaisedButton(
          onPressed: () {
            _testMultiScreenshot();
          },
          child: Text("Pressed me"),
        ),              
```