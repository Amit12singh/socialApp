import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:myapp/services/user_service.dart';
import 'package:myapp/widgets/ImageViewer.dart';
import 'dart:io';


class profileAvatar extends StatefulWidget {

final imageUrl;
  final bool isCurrentUser;

  const profileAvatar(
      {Key? key, required this.imageUrl, required this.isCurrentUser})
      : super(key: key);

  @override
  State<profileAvatar> createState() => _profileAvatarState();
}

class _profileAvatarState extends State<profileAvatar> {

  XFile? _image;
String imagePath = '';

  final ImagePicker _picker = ImagePicker();
  Future<void> selectImage() async {
    XFile? image = await _picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      setState(() {
        _image = image;
      });
      changeProfile();
    }
  }

  @override
  void initState() {
   
    super.initState();
    imagePath = widget.imageUrl;
  }

  void changeProfile() {
    if (_image != null) {
      Navigator.of(context).push(MaterialPageRoute(
          builder: (context) =>
              ImageViewer(
                image: _image,
                file: true,
                imagePath: '',
              )));
    }
  }

  void updateImagePath(path) {
    setState(() {
      imagePath = path;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        color: Colors.white,
        child: Padding(
          padding: const EdgeInsets.only(top: 8.0),
          child: Stack(
            children: <Widget>[
              _image != null
                  ? ClipOval(
                      child: Image.file(
                        fit: BoxFit.cover,
                        File(_image!.path),
                        width: 110,
                        height: 120,
                      ),
                    )
                  : isNetworkImage()
                      ? CircleAvatar(
                          backgroundColor: Colors.transparent,
                          radius: 55.0,
                          backgroundImage: NetworkImage(
                              widget.imageUrl), // Add your image path here
                        )
                      : CircleAvatar(
                backgroundColor: Colors.transparent,
                radius: 55.0,
                backgroundImage: AssetImage(
                              widget.imageUrl), // Add your image path here
              ),
              Positioned(
                right: 4,
                bottom: 5,
                child: GestureDetector(
                  onTap: () {
                    showModalBottomSheet(
                      context: context,
                      builder: (BuildContext context) {
                        return Container(
                          height: 200,
                          color: const Color.fromARGB(255, 167, 135,
                              135), // Background color of the bottom sheet
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                             
                              widget.isCurrentUser
                                  ? TextButton(
                                onPressed: () {
                                  selectImage();
                                },
                                child: const Row(
                                  children: [
                                    Icon(
                                      Icons.add_a_photo_outlined,
                                      color: Colors.white,
                                      size: 30,
                                    ),
                                    SizedBox(
                                      width: 10,
                                    ),
                                    Text(
                                      "Change Profile",
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 20,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  ],
                                ),
                                    )
                                  : const SizedBox(),
                              TextButton(
                                onPressed: () {
                                  Navigator.of(context).push(MaterialPageRoute(
                                      builder: (context) => ImageViewer(
                                            file: false,
                                            imagePath:
                                                widget.imageUrl,
                                          )));
                                },
                                child: const Row(
                                  children: [
                                    Icon(
                                      Icons.image_outlined,
                                      color: Colors.white,
                                      size: 30,
                                    ),
                                    SizedBox(
                                      width: 10,
                                    ),
                                    Text(
                                      "View Profile",
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 20,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                    );
                  },
                  child: Container(
                    height: 30,
                    width: 30,
                    decoration: const BoxDecoration(
                      color: const Color.fromARGB(255, 167, 135,
                          135), // Background color for the button
                      shape: BoxShape.circle, // Make the container circular
                    ),
                    child: const Icon(
                      Icons.add,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  bool isNetworkImage() {
    return widget.imageUrl.startsWith('http') ||
        widget.imageUrl.startsWith('https');
  }
}
