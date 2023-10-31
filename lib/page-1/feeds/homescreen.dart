import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:myapp/page-1/messagelist.dart';
import 'package:myapp/page-1/ProfileScreen.dart';
import 'package:myapp/page-1/create_post_screen.dart';
import 'package:myapp/page-1/feeds/bottombar.dart';
import 'package:myapp/page-1/feeds/post.dart';
import 'package:myapp/utilities/localstorage.dart';

class FeedScreen extends StatefulWidget {
  const FeedScreen({Key? key});

  @override
  State<FeedScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<FeedScreen> {
  final PageController _pageController = PageController(initialPage: 0);
  final HandleToken useService = HandleToken();
  bool isExpanded = false;

  var _user = null;
  int currentPage = 0;

 

 

  @override
  Widget build(BuildContext context) {
    return PageView.builder(
      controller: _pageController,
      itemCount: 3,
      onPageChanged: (page) {
        setState(() {
          currentPage = page;
        });
      },
      itemBuilder: (context, index) {
        if (index == 0) {
          return Scaffold(
            appBar: AppBar(
              systemOverlayStyle: const SystemUiOverlayStyle(
                statusBarColor: Colors.white,
                statusBarIconBrightness: Brightness.dark,
                statusBarBrightness: Brightness.light,
              ),
              elevation: 0,
              backgroundColor: Colors.white,
              leading: IconButton(
                icon: Container(
                  width: 60,
                  height: 60,
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                  ),
                  child: Image.asset(
                    'assets/page-1/images/ellipse-1-bg.png',
                    width: 45,
                    height: 45,
                  ),
                ),
                onPressed: () {},
              ),
              titleSpacing: 3,
              title: const Text(
                'PPSONA',
                style: TextStyle(
                  color: Color.fromARGB(255, 167, 135, 135),
                  decoration: TextDecoration.none,
                  fontFamily: 'PermanentMarker-Regular',
                  fontWeight: FontWeight.bold,
                  fontSize: 25,
                ),
              ),
              // actions: [
              //   IconButton(
              //     icon: const Icon(
              //       Icons.search,
              //       size: 25,
              //       color: Colors.black,
              //     ),
              //     onPressed: () {
              //       Navigator.of(context).push(
              //         MaterialPageRoute(
              //           builder: (context) => SearchPage(),
              //         ),
              //       );
              //     },
              //   ),
              // ],
            ),
            body: Column(
              children: [
                Container(
                  width: double.infinity,
                  height: 56,
                  color: Colors.white,
                  child: Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 8.0),
                        child: Column(
                          children: [Avatar(user: _user)],
                        ),
                      ),
                      Expanded(
                        child: Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(
                                  left: 10, top: 2, right: 10),
                              child: OutlinedButton(
                                onPressed: () {
                                  Navigator.of(context).push(
                                    MaterialPageRoute(
                                      builder: (context) =>
                                          const CreatePostScreen(),
                                    ),
                                  );
                                },
                                style: OutlinedButton.styleFrom(
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  side: const BorderSide(
                                    width: 1.0,
                                    color: Color.fromARGB(80, 167, 135, 135),
                                  ),
                                ),
                                child: const Text(
                                  "                    What's on your mind?                      ",
                                  style: TextStyle(color: Colors.grey),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                // const Divider(
                //   color: Colors.grey,
                //   thickness: 0,
                // ),
                const Expanded(
                  child: PostScreen(),
                ),
              ],
            ),
            bottomNavigationBar: Bottombar(
              onIconPressed: () {
                final currentRoute = ModalRoute.of(context);
                if (currentRoute != null &&
                    currentRoute.settings.name == '/FeedScreen') {
                  return;
                }

                Navigator.pushNamed(context, '/FeedScreen');
              },
            ),
          );
        } else if (index == 1) {
          return const MessengerPage();
        } else if (index == 2) {
          return const ProfileScreen();
        }
      },
    );
  }
}
