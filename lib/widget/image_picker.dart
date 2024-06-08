import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

File? imagepicked;

class UserImagePicker extends StatefulWidget {
  const UserImagePicker({Key? key}) : super(key: key);

  @override
  State<UserImagePicker> createState() => _UserImagePickerState();
}

class _UserImagePickerState extends State<UserImagePicker> {
  void imagepicker() async {
    try {
      final image = await ImagePicker().pickImage(
        source: ImageSource.camera,
        imageQuality: 50,
        maxWidth: 150,
      );

      if (image != null) {
        setState(() {
          imagepicked = File(image.path);
        });
      } else {
        // Handle case when image picking is canceled or fails
        print("Image picking canceled or failed");
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text("Faire")));
      }
    } catch (e) {
      // Handle any errors that occur during image picking or uploading
      print('Error picking or uploading image: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CircleAvatar(
          foregroundImage: imagepicked != null ? FileImage(imagepicked!) : null,
        ),
        TextButton(
          onPressed: () {
            imagepicker();
          },
          child: Text('Add Image'),
        ),
      ],
    );
  }
}
