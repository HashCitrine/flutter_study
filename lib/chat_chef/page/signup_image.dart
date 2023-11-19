import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class SignupImage extends StatefulWidget {
  const SignupImage({super.key, required this.addImageFunc});

  final Function(File image) addImageFunc;

  @override
  State<SignupImage> createState() => _SignupImageState();
}

class _SignupImageState extends State<SignupImage> {
  File? image;

  void _pickImage() async {
    final imagePicker = ImagePicker();
    final picked = await imagePicker.pickImage(
        source: ImageSource.gallery, imageQuality: 50, maxHeight: 150);

    setState(() {
      if (picked != null) {
        image = File(picked.path);
      }
    });

    widget.addImageFunc(image!);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(top: 30),
      width: 150,
      height: 300,
      child: Column(
        children: [
          CircleAvatar(
            radius: 40,
            backgroundColor: Colors.blue,
            backgroundImage: image != null ? FileImage(image!) : null,
          ),
          SizedBox(
            height: 10,
          ),
          TextButton.icon(
            onPressed: () {
              _pickImage();
            },
            icon: Icon(Icons.image),
            label: Text('Add Icon'),
          ),
          SizedBox(
            height: 80,
          ),
          TextButton.icon(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(Icons.close),
            label: Text('Close'),
          ),
        ],
      ),
    );
  }
}
