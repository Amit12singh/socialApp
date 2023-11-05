import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:myapp/models/article_model.dart';
import 'package:myapp/page-1/feeds/homescreen.dart';
import 'package:myapp/services/article_service.dart';
import 'package:myapp/page-1/feeds/post_imgaes_view.dart';
import 'package:page_transition/page_transition.dart';

class CreatePostScreen extends StatefulWidget {
  CreatePostScreen({Key? key, this.post}) : super(key: key);

  ArticleModel? post;

  @override
  _CreatePostScreenState createState() => _CreatePostScreenState();
}

class _CreatePostScreenState extends State<CreatePostScreen> {
  TextEditingController postController = TextEditingController();
  PostService postService = PostService();
  List<XFile> _mediaFileList = [];
  final ImagePicker _picker = ImagePicker();
  bool isPosting = false;
  bool isUpdate = false;

  @override
  void initState() {
    super.initState();
    if (widget.post != null) {
      isUpdate = true;
      postController.text = widget.post!.title;
    }
  }

  void _createPost() async {
    if (isPosting) return;
    setState(() {
      isPosting = true;
    });

    final _isPostCreated = !isUpdate
        ? await postService.createPost(postController.text, _mediaFileList)
        : await postService.updatePost(
            postController.text, [], [], widget.post?.id ?? '');

    if (_isPostCreated) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
            'Post created successfully',
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.black,
            ),
          ),
          duration: Duration(seconds: 2),
          backgroundColor: Colors.green,
          behavior: SnackBarBehavior.floating,

        ),
      );

      Navigator.of(context).pushReplacement(
        PageTransition(
          type: PageTransitionType.scale,
          alignment: Alignment.bottomCenter,
          child: const FeedScreen(),
        ),
      );
    }
    setState(() {
      isPosting = false;
    });
  }

  Future<void> _captuteImage() async {
    var image =
        await _picker.pickImage(source: ImageSource.camera, imageQuality: 1);

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
        titleSpacing: 3,
        title: const Text(
          'PPSONA',
          style: TextStyle(
            color: const Color(0xFFA78787),
            decoration: TextDecoration.none,
            fontFamily: 'PermanentMarker-Regular',
            fontWeight: FontWeight.bold,
            fontSize: 25,
          ),
        ),
        iconTheme: const IconThemeData(
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
                margin: const EdgeInsets.only(bottom: 25.0),
                width: double.infinity,
                child: Row(
                  children: [
                    Container(
                      margin: const EdgeInsets.only(right: 10.0),
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
                        color: Color(0xff000000),
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                  margin: const EdgeInsets.only(bottom: 25.0),
                  child: TextField(
                    controller: postController,
                    decoration: const InputDecoration(
                      hintText: "What’s on your mind?",
                      hintStyle: TextStyle(
                        fontFamily: 'Poppins',
                        fontSize: 16,
                        fontWeight: FontWeight.w400,
                        color: Color(0xffbebebe),
                      ),
                      border: InputBorder.none,
                    ),
                    style: const TextStyle(
                      fontFamily: 'Poppins',
                      fontSize: 16,
                      fontWeight: FontWeight.w400,
                      color: Color(0xff000000),
                    ),
                    maxLines: null,
                  )),
              const SizedBox(height: 30.0),
              Column(
                children: [
                  Visibility(
                    visible: _mediaFileList.isNotEmpty,
                    child: ImageArrayWidget(imagePaths: _mediaFileList),
                  ),
                ],
              ),
              const SizedBox(height: 30.0),
              if (isPosting)
                Center(
                  child: CircularProgressIndicator(),
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
                      child: const Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SizedBox(
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
                      color: const Color(0xffefe3d7),
                      borderRadius: BorderRadius.circular(6),
                    ),
                    child: InkWell(
                      onTap: () {
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
              if (isPosting)
                const Center(
                  child: CircularProgressIndicator(),
                ),
              const SizedBox(height: 40),
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
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                            color: Colors.black,
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
