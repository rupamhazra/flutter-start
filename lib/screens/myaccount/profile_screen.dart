//import 'dart:html';
import 'package:flutter/material.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:io';
import 'package:async/async.dart';
import 'package:http/http.dart' as http;

class ProfileScreen extends StatefulWidget {
  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  String _name = '';
  File _imageFile;
  final picker = ImagePicker();

  Future getImage(ImageSource source) async {
    final pickedFile = await picker.getImage(source: source);
    print('pickedFile ${pickedFile}');
    setState(() {
      _imageFile = File(pickedFile.path);
    });
  }

  Future<Null> _cropImage() async {
    var cropped = await ImageCropper.cropImage(
        sourcePath: _imageFile.path,
        aspectRatioPresets: [
          CropAspectRatioPreset.square,
          CropAspectRatioPreset.ratio3x2,
          CropAspectRatioPreset.original,
          CropAspectRatioPreset.ratio4x3,
          CropAspectRatioPreset.ratio16x9
        ],
        androidUiSettings: AndroidUiSettings(
            toolbarTitle: 'Cropper',
            toolbarColor: Colors.deepOrange,
            toolbarWidgetColor: Colors.white,
            initAspectRatio: CropAspectRatioPreset.original,
            lockAspectRatio: false),
        iosUiSettings: IOSUiSettings(
          minimumAspectRatio: 1.0,
        ));
  }

  Future<void> uploadImage(File ImageFile) async {
    //var stream = ImageStream();
  }

  void _clear() {
    setState(() {
      _imageFile = null;
    });
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text("Profile")),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "We are in the details page now",
                style: TextStyle(fontSize: 22),
              ),
              if (_imageFile != null) ...[
                Image.file(_imageFile),
                Row(
                  children: [
                    FlatButton(onPressed: _clear, child: Icon(Icons.crop))
                  ],
                ),
              ],
              RaisedButton(
                child: Icon(Icons.photo_camera),
                onPressed: () {
                  getImage(ImageSource.camera);
                },
              ),
              RaisedButton(
                child: Icon(Icons.photo_library),
                onPressed: () {
                  getImage(ImageSource.gallery);
                },
              ),
              RaisedButton(
                child: Icon(Icons.file_upload),
                onPressed: () {
                  //uploadImage();
                },
              )
            ],
          ),
        ));
  }
}
