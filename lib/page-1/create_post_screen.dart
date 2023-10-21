import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:myapp/page-1/feeds/homescreen.dart';
import 'package:myapp/services/article_service.dart';

class CreatePostScreen extends StatefulWidget {
  const CreatePostScreen({Key? key}) : super(key: key);

  @override
  _CreatePostScreenState createState() => _CreatePostScreenState();
}

class _CreatePostScreenState extends State<CreatePostScreen> {
  TextEditingController postController = TextEditingController();
  PostService postService = PostService();
  List _mediaFileList = []; // Change to XFile
  // late List _capturedMedia = []; // Change to XFile
  final ImagePicker _picker = ImagePicker();
  //final _isPostCreated = false;

  @override
  void initState() {
    super.initState();
  }

  void _createPost() async {
    final _isPostCreated =
        await postService.createPost(postController.text, _mediaFileList);

    if (_isPostCreated) {
      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (context) =>
              const FeedScreen(), // Replace RegisterScreen with your actual register screen widget
        ),
      );
    }
  }

  Future<void> _captuteImage() async {
    var image = await _picker.pickImage(source: ImageSource.camera);

    if (image != null) {
      setState(() {
        _mediaFileList = [..._mediaFileList, image];
      });
    }
  }

  Future<void> selectImage() async {
    List<XFile>? images = await _picker.pickMultiImage();

    if (images.isNotEmpty) {
      setState(() {
        _mediaFileList = [..._mediaFileList, ...images];
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
                        image: const DecorationImage(
                          fit: BoxFit.contain,
                          image: AssetImage(
                              'assets/page-1/images/ellipse-4-bg.png'),
                        ),
                      ),
                    ),
                    const Text(
                      'Old Nabhaites',
                      style: TextStyle(
                        fontFamily: 'Inter',
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: const Color(0xff000000),
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                margin: const EdgeInsets.only(bottom: 25.0),
                child: TextFormField(
                  controller: postController,
                  decoration: const InputDecoration(
                    hintText: "What’s on your mind?",
                    hintStyle: TextStyle(
                      fontFamily: 'Poppins',
                      fontSize: 16,
                      fontWeight: FontWeight.w400,
                      color: Color(0xffbebebe),
                    ),
                  ),
                  style: const TextStyle(
                    fontFamily: 'Poppins',
                    fontSize: 16,
                    fontWeight: FontWeight.w400,
                    color: Color(0xff000000),
                  ),
                ),
              ),
              const SizedBox(height: 30.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    width: 150,
                    height: 100,
                    decoration: BoxDecoration(
                      color: const Color(0xffefe3d7),
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
                            child: const Image(
                              image: AssetImage(
                                  'assets/page-1/images/auto-group-dbpd.png'),
                              fit: BoxFit.cover,
                            ),
                          ),
                          const Text(
                            'Photo',
                            style: TextStyle(
                              fontFamily: 'Poppins',
                              fontSize: 14,
                              fontWeight: FontWeight.w400,
                              color: const Color(0xff000000),
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
                      color: const Color(0xffefe3d7),
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
                            child: const Image(
                              image:
                                  AssetImage('assets/page-1/images/camera.png'),
                              fit: BoxFit.cover,
                            ),
                          ),
                          const Text(
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
              const SizedBox(height: 40),
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
                color: const Color.fromARGB(255, 220, 166, 112),
                margin: const EdgeInsets.only(bottom: 50.0),
                child: InkWell(
                  onTap: () {
                    _createPost();
                  },
                  child: Container(
                    width: double.infinity,
                    child: const Padding(
                      padding: EdgeInsets.all(8.0),
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
