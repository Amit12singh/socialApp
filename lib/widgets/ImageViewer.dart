import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:myapp/models/user_model.dart';
import 'package:myapp/services/user_service.dart';
import 'package:myapp/utilities/localstorage.dart';

class ImageViewer extends StatefulWidget {
  final String imagePath;
  final bool file;
  final XFile? image;

  ImageViewer({
    required this.imagePath,
    required this.file,
    this.image,
  });

  @override
  State<ImageViewer> createState() => _ImageViewerState();
}

class _ImageViewerState extends State<ImageViewer> {
  final GraphQLService userService = GraphQLService();
  final HandleToken localstorageSrvice = HandleToken();

  _confirm() async {
    final UserModel? user = await localstorageSrvice.getUser();
    final response = await userService.uploadProfile(
        image: widget.image ?? {} as XFile, id: user!.id);

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          response.message,
          textAlign: TextAlign.center,
          style: const TextStyle(
            color: Colors.black,
          ),
        ),
        backgroundColor: response.success ? Colors.green : Colors.red,
        elevation: 14,
        behavior: SnackBarBehavior.floating,
      ),
    );

    if (response.success) {
      // widget.!updatePath();
      Navigator.of(context).pop();
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        systemOverlayStyle: const SystemUiOverlayStyle(
          statusBarColor: Colors.white,
          statusBarIconBrightness: Brightness.dark,
          statusBarBrightness: Brightness.light,
        ),
        title: Text(widget.file ? "Change Profile picture" : 'View Profile'),
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
      body: Center(
        child: Expanded(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            // mainAxisSize: MainAxisSize.max,
            children: [

              Stack(
                alignment: Alignment.topRight,
                children: [
                  isNetworkImage()
                      ? Container(
                          width: MediaQuery.of(context).size.width,
                          height: MediaQuery.of(context).size.height - 200,
                          child: Image.network(
                            widget.imagePath,
                            fit: BoxFit.cover, // Adjust the fit as needed
                          ),
                        )
                      : widget.file
                          ? ClipOval(
                              child: Image.file(
                                fit: BoxFit.cover,
                                File(widget.image!.path),
                                width: 300,
                                height: 300,
                              ),
                            )
                          : Image.asset(
                              widget.imagePath,
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
              const SizedBox(
                height: 50,
              ),
              widget.file
                  ? Row(
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
                                color: Color.fromARGB(255, 167, 135, 135),
                                fontSize: 16),
                          ),
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        TextButton(
                          onPressed: () {
                            if (widget.file && widget.image != null) {
                              print('run confirm');
                              _confirm();
                            }
                          },
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
                  : const SizedBox()
            ],
          ),
        ),
      ),
    );
  }

  bool isNetworkImage() {
    return widget.imagePath.startsWith('http') ||
        widget.imagePath.startsWith('https');
  }
}
