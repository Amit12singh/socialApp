import 'package:flutter/material.dart';
import 'dart:io';

class ImageArrayWidget extends StatefulWidget {
  final List imagePaths;

  ImageArrayWidget({required this.imagePaths});

  @override
  ImageArrayWidgetState createState() => ImageArrayWidgetState();
}

class ImageArrayWidgetState extends State<ImageArrayWidget> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("Selected Images:"),
        SizedBox(height: 8),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: widget.imagePaths.map((imagePath) {
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: Image.file(
                  File(imagePath.path),
                  width: 100,
                  height: 100,
                  // fit: BoxFit.cover,
                ),
              );
            }).toList(),
          ),
        ),
      ],
    );
  }
}
