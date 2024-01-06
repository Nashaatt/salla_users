import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class ImagePickerr extends StatelessWidget {
  const ImagePickerr({super.key, this.pickedImage, required this.function});

  final XFile? pickedImage;
  final Function function;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Padding(
          padding: const EdgeInsets.all(10.0),
          child: Container(
            width: 100,
            height: 100,
            decoration: BoxDecoration(
              border: Border.all(color: Colors.green.shade300, width: 1),
              shape: BoxShape.circle,
              image: const DecorationImage(
                image: AssetImage(
                  "IMG/user.png",
                ),
                // fit: BoxFit.contain,
              ),
            ),
            child: pickedImage == null
                ? Container(
                    decoration: BoxDecoration(
                      border:
                          Border.all(color: Colors.green.shade200, width: 1),
                      shape: BoxShape.circle,
                    ),
                  )
                : ClipRRect(
                    borderRadius: BorderRadius.circular(50),
                    child: Image.file(
                      File(pickedImage!.path),
                      fit: BoxFit.cover,
                    ),
                  ),
          ),
        ),
        Positioned(
          top: 25,
          bottom: 70,
          right: 30,
          left: 30,
          child: Container(
            color: Colors.transparent,
            child: InkWell(
              borderRadius: BorderRadius.circular(50),
              onTap: () {
                function();
              },
              // ignore: prefer_const_constructors
              child: Icon(
                Icons.add_a_photo_outlined,
                color: Colors.white,
                size: 25,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
