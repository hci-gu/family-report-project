import 'package:family_report_project/screens/homescreen.dart';
import 'package:flutter/material.dart';
import './regulargreenbutton.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import '../helpers/sharedpreferenceshelper.dart';
import 'dart:io';

class ScreenTimeUploadAndroid extends StatefulWidget {
  ScreenTimeUploadAndroid({Key key}) : super(key: key);

  @override
  _ScreenTimeUploadAndroidState createState() =>
      _ScreenTimeUploadAndroidState();
}

class _ScreenTimeUploadAndroidState extends State<ScreenTimeUploadAndroid> {
  File _image;
  final picker = ImagePicker();

  //get video from photo library
  Future getImage() async {
    final pickedFile = await picker.getVideo(source: ImageSource.gallery);

    setState(() {
      if (pickedFile != null) {
        _image = File(pickedFile.path);
      } else {
        print('No image selected.');
      }
    });

    await uploadToStorage();
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => HomeScreen()),
    );
  }

  //upload video to firebase storage
  Future uploadToStorage() async {
    try {
      Future<String> familyUID = SharedPreferencesHelper.getFamilyMemberUid();
      final DateTime now = DateTime.now();
      final int millSeconds = now.millisecondsSinceEpoch;
      final String month = now.month.toString();
      final String date = now.day.toString();
      String storageId;
      familyUID.then((value) {
        storageId = (millSeconds.toString() + value);
      });

      final String today = ('$month-$date');

      Reference ref = FirebaseStorage.instance
          .ref()
          .child("videos")
          .child("$today - $storageId");
      UploadTask uploadTask =
          ref.putFile(_image, SettableMetadata(contentType: 'video/mp4'));
      uploadTask.then((res) => print(res.ref.getDownloadURL()));
    } catch (error) {
      print(error);
    }
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
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
                  "This was built for uploading your screentime data. The researcher will help you with this step at the end of the study. You will upload a screen recording of your screentime here."),
            ),
            Center(
              child: _image == null
                  ? Text('No video selected.')
                  : Text("screen recording selected!"),
            ),
            RegularGreenButton("Upload Recording", getImage)
          ],
        ),
      ),
    );
  }
}
