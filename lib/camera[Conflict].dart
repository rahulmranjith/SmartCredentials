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
      return new Column(
      
        children: <Widget>[
          new Expanded(
          child: new Padding(
            padding: const EdgeInsets.all(5.0),
            child: new Center(
              child: new AspectRatio(
                aspectRatio: controller.value.aspectRatio,
                child: new CameraPreview(controller),
              ),
            ),
          ),
        ),
          
          new FlatButton(
            child: const Icon(Icons.camera),
            onPressed: controller.value.isStarted ? capture : null,
          )
        ],
      );
    }
    return new Container();
  }

  Widget imageWidget() {
    return new Expanded(
      child: new Align(
        alignment: Alignment.centerRight,
        child: new SizedBox(
          child: new Image.file(new File(imagePath)),
          width: 64.0,
          height: 64.0,
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
