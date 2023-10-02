import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class ImagePickerWidget extends StatefulWidget {
  const ImagePickerWidget({super.key, required this.setPicture});
  final void Function(File) setPicture;

  @override
  State<ImagePickerWidget> createState() => _ImagePickerState();
}

class _ImagePickerState extends State<ImagePickerWidget> {
  File? _selectedPicture;

  final double imageBorderRadius = 6;
  double imageBorderWidth = 0.25;

  void _takePicture() async {
    final imagePicker = ImagePicker();
    final pic = await imagePicker.pickImage(source: ImageSource.camera);

    if (pic == null) {
      return;
    }

    setState(() {
      _selectedPicture = File(pic.path);
      imageBorderWidth = 1;
    });
    widget.setPicture(_selectedPicture!);
  }

  void _changeImage() {
    showDialog(
        context: context,
        builder: (ctx) => AlertDialog(
              title: const Text('Change to new image'),
              content: const Text(
                  'Are you sure you want to replace the current image with a new one?'),
              actions: [
                TextButton(
                  onPressed: () => Navigator.pop(ctx),
                  child: const Text('Cancel'),
                ),
                ElevatedButton(
                    onPressed: () {
                      Navigator.pop(ctx);
                      _takePicture();
                    },
                    child: const Text('Okay'))
              ],
            ));
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 350,
      width: double.infinity,
      decoration: ShapeDecoration(
        shape: BeveledRectangleBorder(
            borderRadius: BorderRadius.circular(imageBorderRadius),
            side: BorderSide(
                width: imageBorderWidth,
                color: Theme.of(context).colorScheme.secondary)),
      ),
      child: Center(
        child: _selectedPicture == null
            ? TextButton.icon(
                onPressed: _takePicture,
                icon: const Icon(Icons.camera),
                label: const Text('Take a Picture'),
              )
            : InkWell(
                onTap: _changeImage,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(imageBorderRadius + 2.5),
                  clipBehavior: Clip.antiAlias,
                  child: Image.file(
                    _selectedPicture!,
                    fit: BoxFit.cover,
                    width: double.infinity,
                    height: double.infinity,
                  ),
                ),
              ),
      ),
    );
  }
}
