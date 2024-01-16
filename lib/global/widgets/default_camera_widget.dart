import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import '../constants.dart';

typedef OnImageSelected = Function(File? image);

//ignore: must_be_immutable
class DefaultCameraWidget extends StatefulWidget {
  final double height;
  final double width;
  final OnImageSelected onImageSelected;

  File? image;

  DefaultCameraWidget(
      {super.key, this.image, required this.height, required this.width, required this.onImageSelected});

  @override
  State<DefaultCameraWidget> createState() => _DefaultCameraWidgetState();
}

class _DefaultCameraWidgetState extends State<DefaultCameraWidget> {
  final ImagePicker _imagePicker = ImagePicker();

  _DefaultCameraWidgetState();

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        var source = ImageSource.gallery;
        XFile? image =
        await _imagePicker.pickImage(source: source, imageQuality: 50);

        if (image != null) {
          widget.onImageSelected(File(image.path));
        }
      },
      child: ClipOval(
        child: Container(
          height: widget.height,
          width: widget.width,
          color: Colors.white,
          child: Icon(
            Icons.camera_alt_rounded,
            size: 100 / widget.width * .6 * widget.height * .6,
            color: kDefaultPrimaryColor,
          ),
        ),
      ),
    );
  }
}
