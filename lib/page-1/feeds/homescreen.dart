import 'package:flutter/material.dart';
import 'package:myapp/page-1/createpostScreen.dart';
import 'package:myapp/page-1/feeds/bottombar.dart';
import 'package:myapp/page-1/feeds/post.dart';
import 'package:myapp/services/article_service.dart';
import 'package:myapp/utilities/localstorage.dart';

class FeedScreen extends StatefulWidget {
  const FeedScreen({Key? key});

  @override
  State<FeedScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<FeedScreen> {
  final PostService postService = PostService();
  final HandleToken useService = HandleToken();
  bool isExpanded = false;

  List? posts; // Use ArticleModel for posts

  var _user = null;

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  void _loadData() async {
    final user = await useService.getUser();
    final List _posts = await postService.getArticles();
    print('here home screen $_posts');
    print(_posts);

    setState(() {
      _user = user;
      posts = _posts;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: IconButton(
          icon: Container(
            width: 60, // Set the desired width
            height: 60, // Set the desired height
            decoration: BoxDecoration(
              shape: BoxShape.circle,
            ),
            child: Image.asset(
              'assets/page-1/images/ellipse-1-bg.png', // Replace with your circular icon asset path
              width: 45, // Set the same width as the container
              height: 45, // Set the same height as the container
            ),
          ),
          onPressed: () {
            // Handle the action when the circular icon is tapped
          },
        ),
        titleSpacing: 3,
        title: Text(
          'PPSONA',
          style: TextStyle(
            color: Color.fromARGB(255, 167, 135, 135),
            decoration: TextDecoration.none,
            fontFamily: 'PermanentMarker-Regular',
            fontWeight: FontWeight.bold,
            fontSize: 25,
          ),
        ),
        actions: [
          IconButton(
            icon: Icon(
              Icons.search,
              size: 25,
              color: Colors.black,
            ),
            onPressed: () {
              // Handle the action when the search icon is tapped
            },
          ),
        ],
      ),
      body: Column(
        children: [
          SizedBox(
            height: 10,
          ),
          Container(
            width: double.infinity, // Expand the container to full width
            height: 50,
            color: Colors.white,
            child: Row(
              children: [
                Column(
                  children: [
                    IconButton(
                      icon: Icon(Icons.person_pin, size: 40),
                      onPressed: () {},
                    ),
                  ],
                ),
                Expanded(
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 10, top: 2),
                        child: OutlinedButton(
                          onPressed: () {
                            Navigator.of(context).pushReplacement(
                              MaterialPageRoute(
                                builder: (context) => const CreatePostScreen(),
                              ),
                            );
                          },
                          style: OutlinedButton.styleFrom(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(25),
                            ),
                            side: BorderSide(
                              width: 1.0,
                              color: Colors.black,
                            ),
                          ),
                          child: Text(
                            "                    What's on your mind?                      ",
                            style: TextStyle(color: Colors.black),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Divider(
            color: Colors.black,
            thickness: 0,
          ),
          Expanded(child: PostScreen(posts: posts ?? [])),
        ],
      ),
      bottomNavigationBar: Bottombar(),
    );
  }
}
