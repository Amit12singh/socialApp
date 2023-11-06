import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:myapp/widgets/ImageViewer.dart';

class profileAvatar extends StatefulWidget {
  @override
  State<profileAvatar> createState() => _profileAvatarState();
}

class _profileAvatarState extends State<profileAvatar> {
  XFile? _image;

  final ImagePicker _picker = ImagePicker();
  Future<void> selectImage() async {
    XFile? image = await _picker.pickImage(source: ImageSource.gallery);

    if (image != null) {
      setState(() {
        _image = image;
      });
      chaneProfile();
    }
  }

  @override
  void initState() {
    super.initState();
  }

  void chaneProfile() {
    if (_image != null) {
      Navigator.of(context).push(MaterialPageRoute(
          builder: (context) =>
              ImageViewer(imagePath: _image!.path, file: true)));
    }
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
              const CircleAvatar(
                backgroundColor: Colors.transparent,
                radius: 55.0,
                backgroundImage: AssetImage(
                    'assets/page-1/images/ellipse-1-bg-gnM.png'), // Add your image path here
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
                              TextButton(
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
                              ),
                              TextButton(
                                onPressed: () {
                                  Navigator.of(context).push(MaterialPageRoute(
                                      builder: (context) => ImageViewer(
                                            file: false,
                                            imagePath:
                                                'assets/page-1/images/ellipse-1-bg-gnM.png',
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
                      color: Colors.white, // Background color for the button
                      shape: BoxShape.circle, // Make the container circular
                    ),
                    child: const Icon(Icons.add),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
