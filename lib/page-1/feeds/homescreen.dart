import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:myapp/models/response_model.dart';
import 'package:myapp/models/user_model.dart';
import 'package:myapp/page-1/About_us.dart';
import 'package:myapp/page-1/Notification_page.dart';
import 'package:myapp/page-1/createpostScreen.dart';
import 'package:myapp/page-1/login.dart';
import 'package:myapp/page-1/messagelist.dart';
import 'package:myapp/page-1/ProfileScreen.dart';
import 'package:myapp/page-1/feeds/postScreen.dart';
import 'package:myapp/services/user_service.dart';
import 'package:myapp/utilities/localstorage.dart';
import 'package:myapp/page-1/SearchPage.dart';
import 'package:page_transition/page_transition.dart';

class FeedScreen extends StatefulWidget {
  const FeedScreen({Key? key}) : super(key: key);

  @override
  State<FeedScreen> createState() => _FeedScreenState();
}

class _FeedScreenState extends State<FeedScreen> {
  final PageController _pageController = PageController(initialPage: 0);
  final HandleToken localStorageService = HandleToken();
  final GraphQLService userService = GraphQLService();
   
  bool isExpanded = false;
  int currentPage = 0;
  late UserModel user;

  @override
  void initState() {
    super.initState();
    _setUser();
  }

  void _setUser() async {
    final UserModel? _user = await localStorageService.getUser();

    setState(() {
      user = _user!;
    });
  }

  void _handleLogout(BuildContext context) async {
    bool isCleared = await localStorageService.clearAccessToken();

    if (isCleared) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
            'Logged out successfully',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.black,
                  ),
          ),
          backgroundColor: Colors.green,
          behavior: SnackBarBehavior.floating,
          elevation: 10,
        ),
      );

      Navigator.of(context).pushAndRemoveUntil(
        PageTransition(
            type: PageTransitionType.scale,
            alignment: Alignment.bottomCenter,
            child: LoginScreen()),
        (Route<dynamic> route) => false,
      );
    }
  }

  void _deleteAccount(BuildContext context) async {
    final BoolResponseModel response =
        await userService.deleteAccount(id: user.id ?? '');

    if (response.success) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            response.message,
            textAlign: TextAlign.center,
            // ignore: prefer_const_constructors
            style: TextStyle(
              color: Colors.black,
            ),
          ),
          backgroundColor: Colors.green,
          behavior: SnackBarBehavior.floating,
          elevation: 10,
        ),
      );

      Navigator.of(context).pushAndRemoveUntil(
        PageTransition(
            type: PageTransitionType.scale,
            alignment: Alignment.bottomCenter,
            child: LoginScreen()),
        (Route<dynamic> route) => false,
      );
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
        elevation: 1,
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
              width: 60,
              height: 60,
            ),
          ),
          onPressed: () {},
        ),
        titleSpacing: 3,
        title: const Text(
          'PPS ONA',
          style: TextStyle(
            color: Color.fromARGB(255, 167, 135, 135),
            decoration: TextDecoration.none,
            fontFamily: 'PermanentMarker-Regular',
            fontWeight: FontWeight.bold,
            fontSize: 25,
          ),
        ),
        actions: currentPage == 0
            ? [
                // IconButton(
                //   icon: const Icon(
                //     Icons.notifications_active,
                //     size: 25,
                //     color: Color.fromARGB(255, 167, 135, 135),
                //   ),
                //   onPressed: () {
                //     Navigator.of(context).push(
                //       PageTransition(
                //         type: PageTransitionType.scale,
                //         alignment: Alignment.bottomCenter,
                //         child: const NotificationPage(),
                //       ),
                //     );
                //   },
                // ),
                PopupMenuButton<String>(
                  icon: const Icon(
                    Icons.more_vert,
                    color: Color.fromARGB(255, 167, 135, 135),
                  ),
                  onSelected: (value) {
                    if (value == 'about') {
                      Navigator.of(context).push(
                        PageTransition(
                          type: PageTransitionType.scale,
                          alignment: Alignment.bottomCenter,
                          child: const About_us(),
                        ),
                      );
                    }
                  },
                  itemBuilder: (BuildContext context) => [
                    const PopupMenuItem<String>(
                      value: 'about',
                      child: Text('About Us'),
                    ),
                  ],
                ),
              ]
            : currentPage == 4
                ? [
                    PopupMenuButton<String>(
                      icon: const Icon(
                        Icons.more_vert,
                        color: Colors.black,
                      ),
                      onSelected: (value) {
                        if (value == 'log_out') {
                          _handleLogout(context);
                        }
                        if (value == 'delete_account') {
                          _deleteAccount(context);
                        }
                      },
                      itemBuilder: (BuildContext context) {
                        return <PopupMenuEntry<String>>[
                          const PopupMenuItem<String>(
                            value: 'log_out',
                            child: ListTile(
                              leading: Icon(Icons.exit_to_app),
                              title: Text('Log Out'),
                            ),
                          ),
                          const PopupMenuItem<String>(
                            value: 'delete_account',
                            child: ListTile(
                              leading: Icon(Icons.exit_to_app),
                              title: Text('Delete Account'),
                            ),
                          ),
                        ];
                      },
                    ),
                  ]
                : [],
      ),
      body: PageView(
        controller: _pageController,
        onPageChanged: (page) {
          setState(() {
            currentPage = page;
          });
        },
        children: <Widget>[
          const PostScreen(),
          const SearchPage(),
          CreatePostScreen(user: user),
          const MessengerPage(),
          const ProfileScreen(),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.white,
        unselectedItemColor: Colors.grey,
        type: BottomNavigationBarType.fixed,
        iconSize: 22,
        selectedItemColor: const Color.fromARGB(255, 167, 135, 135),
        currentIndex: currentPage,
        onTap: (index) {
          setState(() {
            currentPage = index;
          });
          _pageController.jumpToPage(index);
        },
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.search_rounded),
            label: 'Search',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.add),
            label: 'Create',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.message),
            label: 'Messages',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
      ),
      // floatingActionButton: Visibility(
      //   visible: MediaQuery.of(context).viewInsets.bottom == 0.0,
      //   child: FloatingActionButton(
      //     onPressed: () {
      //       Navigator.of(context).push(
      //         PageTransition(
      //           type: PageTransitionType.scale,
      //           alignment: Alignment.bottomCenter,
      //           child: CreatePostScreen(),
      //         ),
      //       );
      //     },
      //     backgroundColor: const Color.fromARGB(255, 167, 135, 135),
      //     elevation: 6,
      //     child: const Icon(Icons.add),
      //   ),
      // ),
      // floatingActionButtonLocation:
      //     FloatingActionButtonLocation.miniCenterDocked,
      //  resizeToAvoidBottomInset: false, // fluter 2.x
    );
  }
}
