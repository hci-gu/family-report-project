import 'package:flutter/material.dart';
import './regulargreenbutton.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';

class ScreenTimeUpload extends StatefulWidget {
  ScreenTimeUpload({Key key}) : super(key: key);

  @override
  _ScreenTimeUploadState createState() => _ScreenTimeUploadState();
}

class _ScreenTimeUploadState extends State<ScreenTimeUpload> {
  File _image;
  final picker = ImagePicker();

  Future getImage() async {
    final pickedFile = await picker.getVideo(source: ImageSource.gallery);

    setState(() {
      if (pickedFile != null) {
        _image = File(pickedFile.path);
      } else {
        print('No image selected.');
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Screen Time Upload"),
      ),
      body: Container(
        margin: EdgeInsets.all(15),
        child: ListView(
          children: [
            Container(
              margin: EdgeInsets.only(top: 10),
              width: double.infinity,
              child: Text(
                  "This was built for iOS users to give their screentime usage. Due to restrictions, you will have to take a screentime recording of the screentime and upload it. Below are instructions on how you can do it. "),
            ),
            Container(
              margin: EdgeInsets.only(top: 30),
              width: double.infinity,
              child: Text(
                "Step - 1",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
            Container(
              width: double.infinity,
              margin: EdgeInsets.only(top: 10),
              child: Text(
                  "Go to Settings -> Control Center -> tap plus on screen recording."),
            ),
            Container(
              margin: EdgeInsets.only(top: 10),
              width: double.infinity,
              child: Text(
                "Step - 2",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
            Container(
              width: double.infinity,
              margin: EdgeInsets.only(top: 10),
              child: Text("Now go to Settings -> Screentime"),
            ),
            Container(
              margin: EdgeInsets.only(top: 10),
              width: double.infinity,
              child: Text(
                "Step - 3",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
            Container(
              width: double.infinity,
              margin: EdgeInsets.only(top: 10),
              child: Text(
                  "Turn on Screentime if its turned off. If it's already switched on, click on See All Activity -> Week"),
            ),
            Container(
              margin: EdgeInsets.only(top: 10),
              width: double.infinity,
              child: Text(
                "Step - 4",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
            Container(
              width: double.infinity,
              margin: EdgeInsets.only(top: 10),
              child: Text(
                  "Now open control center, click on the dot with a circle icon to start recording. While the recording is going on, click on each day's bar to view the screentime"),
            ),
            Container(
              margin: EdgeInsets.only(top: 10),
              width: double.infinity,
              child: Text(
                "Step - 5",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
            Container(
              width: double.infinity,
              margin: EdgeInsets.only(top: 10),
              child: Text(
                  "Once done, tap on the top left red status (if on iphone X or above) or the top red status bar to turn off screen recording"),
            ),
            Container(
              margin: EdgeInsets.only(top: 10),
              width: double.infinity,
              child: Text(
                "Step - 6",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
            Container(
              width: double.infinity,
              margin: EdgeInsets.only(top: 10, bottom: 20),
              child: Text(
                  "Upload the screen recording you just took by clicking on the button below"),
            ),
            Center(
              child: _image == null
                  ? Text('No image selected.')
                  : Image.file(_image),
            ),
            RegularGreenButton("Upload Recording", getImage)
          ],
        ),
      ),
    );
  }
}
