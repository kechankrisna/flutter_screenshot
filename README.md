# flutter_screenshot

Flutter screenshot originally from screenshot package by extend more methods.

## Getting Started

```
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
