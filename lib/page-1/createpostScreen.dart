import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:myapp/models/article_model.dart';
import 'package:myapp/models/user_model.dart';
import 'package:myapp/page-1/feeds/homescreen.dart';
import 'package:myapp/services/article_service.dart';
import 'package:myapp/page-1/feeds/post_imgaes_view.dart';
import 'package:myapp/utilities/localstorage.dart';
import 'package:myapp/widgets/processingRequest.dart';
import 'package:page_transition/page_transition.dart';

class CreatePostScreen extends StatefulWidget {
  CreatePostScreen({Key? key, this.post, this.user}) : super(key: key);

  ArticleModel? post;
  UserModel? user;

  @override
  _CreatePostScreenState createState() => _CreatePostScreenState();
}

class _CreatePostScreenState extends State<CreatePostScreen> {
  TextEditingController postController = TextEditingController();
  PostService postService = PostService();
  List<XFile> _mediaFileList = [];
  final ImagePicker _picker = ImagePicker();
  // final HandleToken localStorageService = HandleToken();
  bool isPosting = false;
  bool isUpdate = false;
  // late UserModel user;

  @override
  void initState() {
    super.initState();
    // _setUser();
    if (widget.post != null) {
      isUpdate = true;
      postController.text = widget.post!.title;
    }
  }

  // void _setUser() async {
  //   final UserModel? _user = await localStorageService.getUser();

  //   setState(() {
  //     user = _user!;
  //   });
  // }
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
      Navigator.of(context).pushReplacement(
        PageTransition(
          type: PageTransitionType.scale,
          alignment: Alignment.bottomCenter,
          child: const FeedScreen(),
        ),
      );
    }
    // Navigator.of(context).pop();
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

    if (!_isPostCreated) {
      Navigator.of(context).pop();
    }

    setState(() {
      isPosting = false;
    });
  }

  Future<void> _captuteImage() async {
    try {
      var image = await _picker.pickImage(
        source: ImageSource.camera,
        imageQuality: 1,
      );

      if (image != null) {
        setState(() {
          _mediaFileList = [..._mediaFileList, image];
        });
      }
    } catch (e) {
      final a = 2;
      print(e.toString());
    }
  }

  Future<void> selectImage() async {
    try {
      List<XFile>? images = await _picker.pickMultiImage();

      if (images.isNotEmpty) {
        setState(() {
          _mediaFileList = [..._mediaFileList, ...images];
        });
      }
    } catch (e) {
      final a = e.toString();
      final b = 2;
      print(e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: widget.post != null
          ? AppBar(
              systemOverlayStyle: const SystemUiOverlayStyle(
                statusBarColor: Color.fromARGB(255, 167, 135, 135),
                statusBarIconBrightness: Brightness.dark,
                statusBarBrightness: Brightness.light,
              ),
              elevation: 1,
              backgroundColor: Colors.white,
              leading: IconButton(
                icon: const Icon(
                  Icons.arrow_back_ios,
                  color: Color(0xff643600),
                ),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
              centerTitle: true,
              title: const Text(
                'Edit post',
                style: TextStyle(color: Color(0xff643600)),
              ),
            )
          : null,
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
                      width: 50,
                      height: 50,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(22),
                        image: widget.user?.profilePicture != null
                            ? DecorationImage(
                                fit: BoxFit.cover,
                                image: NetworkImage(
                                    widget.user?.profilePicture?.path ?? ''),
                              )
                            : const DecorationImage(
                                fit: BoxFit.contain,
                                image: AssetImage(
                                    'assets/page-1/images/ellipse-4-bg.png'),
                              ),
                      ),
                    ),
                    Text(
                      widget.user?.fullName ?? '',
                      style: const TextStyle(
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
              if (isPosting) const SizedBox(height: 30.0),
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
              const SizedBox(height: 40),
              ElevatedButton(
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all<Color>(
                    Color(0xff643600),
                  ),
                ),
                onPressed: () async {
                  if (postController.text.isNotEmpty) {
                    showProcessingDialog(context);
                    _createPost();
                  }
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
                          color: Color.fromARGB(255, 248, 245, 245),
                        ),
                      ),
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
}
