import 'package:flutter/material.dart';

class ImageViewer extends StatelessWidget {
  final String imagePath;

  ImageViewer({required this.imagePath});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Stack(
          alignment: Alignment.topRight,
          children: [
            isNetworkImage()
                ? Image.network(
                    imagePath,
                    fit: BoxFit.contain, // Adjust the fit as needed
                  )
                : Image.asset(
                    imagePath,
                    fit: BoxFit.contain, // Adjust the fit as needed
                  ),
            IconButton(
              icon: Icon(Icons.close),
              onPressed: () {
                Navigator.of(context).pop();
                // Add your close button logic here, e.g., to close the image viewer.
              },
            ),
          ],
        ),
      ),
    );
  }

  bool isNetworkImage() {
    return imagePath.startsWith('http') || imagePath.startsWith('https');
  }
}
