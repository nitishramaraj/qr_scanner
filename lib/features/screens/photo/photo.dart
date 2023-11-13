import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Photo extends StatefulWidget {
  const Photo({Key? key}) : super(key: key);

  @override
  _PhotoState createState() => _PhotoState();

  Future<String?> _getName() async {
    final prefs = await SharedPreferences.getInstance();
    final userName = prefs.getString('userName');
    return userName;
  }

}

class _PhotoState extends State<Photo> {
  late XFile _image;

  @override
  void initState() {
    super.initState();
    _image = XFile(''); // Initialize with an empty path
    _openCamera();
  }

  Future<void> _openCamera() async {
    final imagePicker = ImagePicker();
    final pickedImage = await imagePicker.pickImage(source: ImageSource.camera);

    if (pickedImage != null) {
      // Upload the image to Firebase Storage
      await _uploadImageToFirebase(File(pickedImage.path));

      // Navigate back to the previous screen
      Navigator.pop(context);
    } else {
      // Handle the case where the user cancels the camera operation
      Navigator.pop(context);
    }
  }

  Future<void> _uploadImageToFirebase(File imageFile) async {
    try {
      String? userName = await widget._getName(); // Call _getName function
      final storage = FirebaseStorage.instance;
      final Reference storageRef = storage.ref().child("images/$userName/${DateTime.now()}.jpg");

      // Upload the file to Firebase Storage
      await storageRef.putFile(imageFile);

      // Get the download URL
      final String downloadURL = await storageRef.getDownloadURL();

      // Perform any additional actions with the download URL if needed

      print("Image uploaded to Firebase Storage: $downloadURL");
    } catch (e) {
      // Handle the error
      print("Error uploading image to Firebase Storage: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: CircularProgressIndicator(),
      ),
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        toolbarHeight: 100,
        leading: Padding(
          padding: const EdgeInsets.all(8.0),
          child: IconButton(
            icon: const Icon(
              Icons.home,
              color: Colors.black,
              size: 40,
            ),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ),
        actions: [
          Expanded(
            child: Container(
              alignment: Alignment.centerRight,
              padding: const EdgeInsets.all(8.0),
              child: Image.asset(
                "assets/logos/invenger_logo_final-menu.png",
                width: 100,
                height: 100,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
