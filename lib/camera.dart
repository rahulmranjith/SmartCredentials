import 'dart:async';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import 'package:path_provider/path_provider.dart';

List<CameraDescription> cameras;

class CameraApp extends StatefulWidget {
  @override
  _CameraAppState createState() => new _CameraAppState();
}

class _CameraAppState extends State<CameraApp> {
  CameraController controller;
  String imagePath;
  int pictureCount = 0;
  bool imageCaptured = false;

  @override
  void initState() {
    super.initState();
    availableCameras().then((onValue) {
      controller = new CameraController(onValue[0], ResolutionPreset.medium);
      controller.initialize().then((_) {
        if (!mounted) {
          return;
        }
        setState(() {});
      });
    });
  }

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (controller != null) {
      if (!controller.value.initialized) {
        return new Container();
      }

      if (true) {
        return new SafeArea(
            child: new Stack(
          //alignment: Alignment.bottomCenter,
          children: <Widget>[
            new Container(
              child: new Padding(
                padding: const EdgeInsets.all(1.0),
                child: new Center(
                  // child: new AspectRatio(
                  //   aspectRatio: controller.value.aspectRatio,
                  //   child: new CameraPreview(controller),
                  // ),
                  child: new Container(
                      child: new SafeArea(
                    child: new CameraPreview(controller),
                  )),
                ),
              ),
            ),
            imageWidget(),
            new Container(
              alignment: Alignment.topLeft,
              child: new FlatButton(
                child: new Icon(
                  Icons.done,
                  color: Colors.white,
                  size: 60.0,
                ),
                onPressed: () {
                  Navigator.pop(context, imagePath);
                  setState(() {
                    imageCaptured = false;
                  });
                },
              ),
            ),
            new Container(
              alignment: Alignment.bottomCenter,
              child: new FlatButton(
                child: const Icon(
                  Icons.camera,
                  color: Colors.red,
                  size: 56.0,
                ),
                onPressed: controller.value.isStarted ? capture : null,
              ),
            )
          ],
        ));
      } else {
        return new FlatButton(
          child: new Icon(Icons.add_a_photo),
          onPressed: () {
            imageCaptured = true;
            setState(() {});
          },
        );
      }
    }
    return new Container();
  }

  Widget imageWidget() {
    return new Container(
      child: new Align(
        alignment: Alignment.bottomRight,
        child: new SizedBox(
          child: imagePath == null
              ? new Container()
              : new Image.file(new File(imagePath)),
          width: 100.0,
          height: 100.0,
        ),
      ),
    );
  }

  Future<Null> capture() async {
    if (controller.value.isStarted) {
      final Directory tempDir = await getTemporaryDirectory();
      if (!mounted) {
        return;
      }
      final String tempPath = tempDir.path;
      final String path = '$tempPath/picture${pictureCount++}.jpg';
      await controller.capture(path);
      if (!mounted) {
        return;
      }
      setState(
        () {
          imagePath = path;
          print(imagePath);
        },
      );
    }
  }
}
