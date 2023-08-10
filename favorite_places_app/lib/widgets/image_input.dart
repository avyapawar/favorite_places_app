import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class ImageInput extends StatefulWidget {
  const ImageInput({super.key , required this.onPickImage });

final void Function(File image ) onPickImage ;
  @override
  State<ImageInput> createState() => _ImageInputState();
}

class _ImageInputState extends State<ImageInput> {
  File? _pickedImage;

  void _ontakePicture() async {
    final takeImage = ImagePicker();
    final takenImage =
        await takeImage.pickImage(source: ImageSource.camera, maxHeight: 600);
    if (takenImage == null) {
      return;
    }
    setState(() {
      _pickedImage = File(takenImage.path);
    });
    widget.onPickImage(_pickedImage!);
  }

  @override
  Widget build(BuildContext context) {
    Widget content = TextButton.icon(
        icon: const Icon(Icons.camera),
        label: const Text('take picture'),
        onPressed: _ontakePicture);

    if (_pickedImage != null) {
      content = InkWell(
        onTap: _ontakePicture,
          child: Image.file(
        _pickedImage!,
        fit: BoxFit.cover,
        width: double.infinity,
      ));
    }
    return Container(
        alignment: Alignment.center,
        decoration: BoxDecoration(
            border: Border.all(
                width: 1,
                color: Theme.of(context).colorScheme.primary.withOpacity(0.2))),
        height: 250,
        width: double.infinity,
        child: content);
  }
}
