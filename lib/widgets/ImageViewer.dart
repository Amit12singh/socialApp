import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class ImageViewer extends StatelessWidget {
  final String imagePath;
  final bool file;

  ImageViewer({required this.imagePath, required this.file});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        systemOverlayStyle: const SystemUiOverlayStyle(
          statusBarColor: Colors.white,
          statusBarIconBrightness: Brightness.dark,
          statusBarBrightness: Brightness.light,
        ),
        title: Text(file ? "Change Profile picture" : 'View Profile'),
        foregroundColor: const Color.fromARGB(255, 167, 135, 135),
        backgroundColor: Colors.white,
        elevation: 1,
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ),
      body: Column(
        children: [
          Center(
            heightFactor: 1.5,
            child: Stack(
              alignment: Alignment.topRight,
              children: [
                isNetworkImage()
                    ? Image.network(
                        imagePath,
                        fit: BoxFit.contain, // Adjust the fit as needed
                      )
                    : file
                        ? ClipOval(
                            child: Image.file(
                              fit: BoxFit.cover,
                              File(imagePath),
                              width: 300,
                              height: 300,
                            ),
                          )
                        : Image.asset(
                            imagePath,
                            fit: BoxFit.contain, // Adjust the fit as needed
                          ),
                Positioned(
                  top: -10,
                  child: IconButton(
                    icon: const Icon(size: 30, Icons.close),
                    onPressed: () {
                      Navigator.of(context).pop();
                      // Add your close button logic here, e.g., to close the image viewer.
                    },
                  ),
                ),
            
                
              ],
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              TextButton(
                style: ButtonStyle(
                  fixedSize: MaterialStateProperty.all(
                    const Size(120, 50),
                  ),
                  side: MaterialStateProperty.all(const BorderSide(
                    color: const Color.fromARGB(
                        255, 167, 135, 135), // Border color
                    width: 1.0, // Border width
                  )),
                ),
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: const Text(
                  "Cancel",
                  style: TextStyle(
                      color: Color.fromARGB(255, 167, 135, 135), fontSize: 16),
                ),
              ),
              const SizedBox(
                width: 10,
              ),
              TextButton(
                onPressed: () {},
                style: ButtonStyle(
                  fixedSize: MaterialStateProperty.all(
                    const Size(120, 50),
                  ),
                  backgroundColor: MaterialStateProperty.all(
                      const Color.fromARGB(255, 167, 135, 135)),
                ),
                child: const Text(
                  "Confirm",
                  style: TextStyle(color: Colors.white, fontSize: 16),
                ),
              ),
              const SizedBox(
                width: 20,
              )
            ],
          )
        ],
      ),
    );
  }

  bool isNetworkImage() {
    return imagePath.startsWith('http') || imagePath.startsWith('https');
  }
}
