import 'package:flutter/material.dart';
import 'ScreenshotController.dart';

class ScreenshotContainer extends StatefulWidget {
  final Widget child;
  final ScreenshotController controller;
  final GlobalKey containerKey;

  const ScreenshotContainer(
      {Key key, this.controller, this.containerKey, this.child})
      : super(key: key);
  @override
  _ScreenshotContainerState createState() => _ScreenshotContainerState();
}

class _ScreenshotContainerState extends State<ScreenshotContainer>
    with TickerProviderStateMixin {
  ScreenshotController _controller;

  @override
  void initState() {
    super.initState();
    if (widget.controller == null) {
      _controller = ScreenshotController();
    } else {
      _controller = widget.controller;
    }
  }

  @override
  void didUpdateWidget(ScreenshotContainer oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.controller != oldWidget.controller) {
      widget.controller.containerKey = oldWidget.controller.containerKey;
      if (oldWidget.controller != null && widget.controller == null)
        _controller.containerKey = oldWidget.controller.containerKey;
      if (widget.controller != null) {
        if (oldWidget.controller == null) {
          _controller = null;
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return RepaintBoundary(
      key: _controller.containerKey,
      child: widget.child,
    );
  }
}
