import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:flutter/services.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: HomeScreen(),
      theme: ThemeData(colorScheme: ColorScheme.fromSeed(seedColor: Colors.teal)),
      debugShowCheckedModeBanner: false,
    );
  }
}

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  static const platform = MethodChannel('com.example.laboratorna14/time');
  String currentTime = 'Press the button to get the current time';
  File? _image;

  Future<void> getCurrentTime() async {
    try {
      final String result = await platform.invokeMethod('getCurrentTime');
      setState(() {
        currentTime = result;
      });
    } on PlatformException catch (e) {
      setState(() {
        currentTime = "Failed to get time: '${e.message}'.";
      });
    }
  }

  Future<void> pickImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.camera);
    if (pickedFile != null) {
      setState(() {
        _image = File(pickedFile.path);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
          title: Text('CAMERA TOOL',
          style: TextStyle(
            fontWeight: FontWeight.w900,
            fontSize: 20,
            color: Colors.teal
          ),),
      centerTitle: true,),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: getCurrentTime,
              child: Text('Get Current Time'),
            ),
            SizedBox(height: 20,),
            Text(
              currentTime,
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w900,
                color: Colors.red[800]
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 100),
            ElevatedButton(
              onPressed: pickImage,
              child: Text('Take a Photo'),
            ),
            _image != null
                ? Image.file(_image!, height: 200, width: 200)
                : Text('No image selected.'),
          ],
        ),
      ),
    );
  }
}
