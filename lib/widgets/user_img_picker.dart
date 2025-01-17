import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class UserImagePicker extends StatefulWidget {
  const UserImagePicker({super.key, required this.onPickImage});

  final void Function(File pickedImage) onPickImage;


  @override
  State<UserImagePicker> createState() => _UserImagePickerState();
}

class _UserImagePickerState extends State<UserImagePicker> {
  File? _pickedImgFile;
  void _pickImg() async {
    final pickedImg = await ImagePicker().pickImage(
        source: ImageSource.camera, imageQuality: 50, maxWidth: 150);
    if (pickedImg == null) {
      return;
    }

    setState(() {
      // TODO: implement setState
      _pickedImgFile = File(pickedImg.path);
    });
    widget.onPickImage(_pickedImgFile!);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CircleAvatar(
          radius: 40,
          backgroundColor: Colors.grey,
          foregroundImage: _pickedImgFile != null
              ? FileImage(_pickedImgFile!)
              : null,
        ),
        TextButton.icon(
            onPressed: _pickImg,
            icon: Icon(Icons.image),
            label: Text(
              'Add Image',
              style: TextStyle(color: Theme.of(context).primaryColor),
            ))
      ],
    );
  }
}
