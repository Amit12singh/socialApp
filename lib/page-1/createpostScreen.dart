import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:myapp/services/article_service.dart';

class CreatePostScreen extends StatefulWidget {
  const CreatePostScreen({Key? key}) : super(key: key);

  @override
  _CreatePostScreenState createState() => _CreatePostScreenState();
}

class _CreatePostScreenState extends State<CreatePostScreen> {
  TextEditingController postController = TextEditingController();
  PostService postService = PostService();
  List<XFile> _mediaFileList = []; // Change to XFile
  late XFile _capturedMedia; // Change to XFile
  final ImagePicker _picker = ImagePicker();

  @override
  void initState() {
    super.initState();
  }

  void _createPost() async {
    final isPostCreated = await postService
        .createPost(postController.text, [..._mediaFileList, _capturedMedia]);

    print('isPostCreated $isPostCreated');
  }

  Future<void> _captuteImage() async {
    XFile? image = await _picker.pickImage(source: ImageSource.camera);

    if (image != null) {
      setState(() {
        _capturedMedia = image;
      });
    }
  }

  Future<void> selectImage() async {
    List<XFile>? images = await _picker.pickMultiImage();

    if (images != null && images.isNotEmpty) {
      setState(() {
        _mediaFileList = images;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white, // Change the background color to black
        title: Text(
          'Create Post',
          style: TextStyle(
            fontFamily: 'Poppins',
            fontSize: 16,
            fontWeight: FontWeight.w500,
            color: Colors.black, // Change the text color to white
          ),
        ),
        iconTheme: IconThemeData(
          color: Colors.black, // Change the arrow color to white
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                margin: EdgeInsets.only(bottom: 25.0),
                width: double.infinity,
                child: Row(
                  children: [
                    Container(
                      margin: EdgeInsets.only(right: 10.0),
                      width: 44,
                      height: 44,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(22),
                        image: DecorationImage(
                          fit: BoxFit.contain,
                          image: AssetImage(
                              'assets/page-1/images/ellipse-4-bg.png'),
                        ),
                      ),
                    ),
                    Text(
                      'Old Nabhaites',
                      style: TextStyle(
                        fontFamily: 'Inter',
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: Color(0xff000000),
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                margin: EdgeInsets.only(bottom: 25.0),
                child: TextFormField(
                  controller: postController,
                  decoration: InputDecoration(
                    hintText: "What’s on your mind?",
                    hintStyle: TextStyle(
                      fontFamily: 'Poppins',
                      fontSize: 16,
                      fontWeight: FontWeight.w400,
                      color: Color(0xffbebebe),
                    ),
                  ),
                  style: TextStyle(
                    fontFamily: 'Poppins',
                    fontSize: 16,
                    fontWeight: FontWeight.w400,
                    color: Color(0xff000000),
                  ),
                ),
              ),
              SizedBox(height: 30.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    width: 150,
                    height: 100,
                    decoration: BoxDecoration(
                      color: Color(0xffefe3d7),
                      borderRadius: BorderRadius.circular(6),
                    ),
                    child: InkWell(
                      onTap: () {
                        selectImage();
                      },
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            width: 40,
                            height: 40,
                            child: Image(
                              image: AssetImage(
                                  'assets/page-1/images/auto-group-dbpd.png'),
                              fit: BoxFit.cover,
                            ),
                          ),
                          Text(
                            'Photo',
                            style: TextStyle(
                              fontFamily: 'Poppins',
                              fontSize: 14,
                              fontWeight: FontWeight.w400,
                              color: Color(0xff000000),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Container(
                    width: 150,
                    height: 100,
                    decoration: BoxDecoration(
                      color: Color(0xffefe3d7),
                      borderRadius: BorderRadius.circular(6),
                    ),
                    child: InkWell(
                      onTap: () {
                        // Handle Video click
                        // Add your action here
                        _captuteImage();
                      },
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            width: 40,
                            height: 40,
                            child: Image(
                              image:
                                  AssetImage('assets/page-1/images/camera.png'),
                              fit: BoxFit.cover,
                            ),
                          ),
                          Text(
                            'Camera',
                            style: TextStyle(
                              fontFamily: 'Poppins',
                              fontSize: 14,
                              fontWeight: FontWeight.w400,
                              color: Color(0xff000000),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 40),
              // Container(
              //   child: _mediaFileList.isNotEmpty
              //       ? Flexible(
              //           flex: 9,
              //           child: Image.file(File(_mediaFileList[0].path)),
              //         )
              //       : Flexible(
              //           flex: 9,
              //           child: Center(R
              //             child: Text("No Image Selected"),
              //           ),
              //         ),
              // ),
              Container(
                color: Color.fromARGB(255, 220, 166, 112),
                margin: EdgeInsets.only(bottom: 50.0),
                child: InkWell(
                  onTap: () {
                    _createPost();
                  },
                  child: Container(
                    width: double.infinity,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Center(
                        child: Text(
                          'POST',
                          style: TextStyle(
                            fontFamily: 'Poppins',
                            fontSize: 16, // Customize the text size
                            fontWeight: FontWeight.w500,
                            color: Colors.black, // Customize the text color
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
