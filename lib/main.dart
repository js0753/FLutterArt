import 'package:flutter/material.dart';
import 'home.dart';
import 'package:camera/camera.dart';
//import 'dart:async';

void main() async {
  // Ensure that plugin services are initialized so that `availableCameras()`
  // can be called before `runApp()`
  WidgetsFlutterBinding.ensureInitialized();

  // Obtain a list of the available cameras on the device.
  final cameras = await availableCameras();

  // Get a specific camera from the list of available cameras.
  final firstCamera = cameras.first;

  runApp(MyApp(firstCamera));
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  final CameraDescription camera;
  MyApp(this.camera);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'FanArt Demo',
      home: Home("user1", camera, new List()),
    );
  }
}
