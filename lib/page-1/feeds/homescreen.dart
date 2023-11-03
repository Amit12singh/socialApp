import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:myapp/page-1/login.dart';
import 'package:myapp/page-1/messagelist.dart';
import 'package:myapp/page-1/ProfileScreen.dart';
import 'package:myapp/page-1/feeds/post.dart';
import 'package:myapp/services/user_service.dart';
import 'package:myapp/utilities/localstorage.dart';
import 'package:myapp/page-1/SearchPage.dart';


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
        ),
      );

      Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(builder: (context) => LoginScreen()),
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
          actions: currentPage == 0 // Check the current page index
              ? [
                  IconButton(
                    icon: const Icon(
                      Icons.notifications_active,
                      size: 25,
                      color: Color.fromARGB(255, 173, 170, 170),
                    ),
                    onPressed: () {
                      // Handle the action when on the Home page (current page index is 0)
                    },
                  ),
                ]
              : currentPage == 3
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
          children: const <Widget>[
            PostScreen(),
            SearchPage(),

            MessengerPage(), // Messenger page
            ProfileScreen(), // Profile page
          ],
        ),
        bottomNavigationBar: BottomNavigationBar(
          backgroundColor: Colors.white,
          unselectedItemColor: Colors.grey,
          type: BottomNavigationBarType.fixed,
          iconSize: 30,
          selectedItemColor: Color.fromARGB(255, 167, 135, 135),
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
              icon: Icon(Icons.message),
              label: 'Messages',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.person),
              label: 'Profile',
            ),
          ],
        ));
  }
}




