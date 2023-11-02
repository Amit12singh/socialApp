import 'package:flutter/material.dart';
import 'package:myapp/page-1/SearchPage.dart';
import 'package:myapp/page-1/messagelist.dart';
import 'package:myapp/page-1/ProfileScreen.dart';
import 'package:myapp/page-1/feeds/homescreen.dart';

class Bottombar extends StatefulWidget {
  Bottombar({Key? key, required this.onIconPressed}) : super(key: key);
  final VoidCallback onIconPressed;

  @override
  State<Bottombar> createState() => _BottombarState();
}

class _BottombarState extends State<Bottombar> {
  int currentPage = 0;

  @override
  Widget build(BuildContext context) {
    return BottomAppBar(
      child: BottomNavigationBar(
        elevation: 8.0,
        type: BottomNavigationBarType.fixed,
        selectedItemColor: Colors.black,
        showSelectedLabels: true,
        showUnselectedLabels: true,
        selectedFontSize: 8.0,
        iconSize: 25,
        items: [
          BottomNavigationBarItem(
            icon: Padding(
              padding: const EdgeInsets.all(5.0),
              child: Image.asset(
                'assets/icon/home.png',
                width: 24,
                height: 24,
                color: currentPage == 0 ? Colors.black : Colors.white,
              ),
            ),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Padding(
              padding: const EdgeInsets.all(5.0),
              child: Image.asset(
                'assets/icon/search.png',
                width: 24,
                height: 24,
                color: currentPage == 1 ? Colors.black : Colors.grey,

              ),
            ),
            label: 'Search',
          ),
          BottomNavigationBarItem(
            icon: Padding(
              padding: const EdgeInsets.all(5.0),
              child: Image.asset(
                'assets/icon/messenger.png',
                width: 24,
                height: 24,
              ),
            ),
            label: 'Message',
            // onPressed: onIconPressed,
          ),
          BottomNavigationBarItem(
            icon: Padding(
              padding: const EdgeInsets.all(5.0),
              child: Image.asset(
                'assets/icon/profile.png',
                width: 24,
                height: 24,
              ),
            ),
            label: 'Profile',
          ),
        ],
        onTap: (int index) {
          switch (index) {
            case 0:
              setState(() {
                currentPage = 0;
              });
              Navigator.of(context).pushReplacement(
                MaterialPageRoute(
                  builder: (context) => const FeedScreen(),
                ),
              );
              break;
            case 1:
            
              setState(() {
                currentPage = 1;
              });
              print(currentPage);
              Navigator.of(context).pushReplacement(
                MaterialPageRoute(
                  builder: (context) => const SearchPage(),
                ),
              );
              break;
            case 2:
              setState(() {
                currentPage = 2;
              });

              Navigator.of(context).pushReplacement(
                MaterialPageRoute(
                  builder: (context) => const MessengerPage(),
                ),
              );
              break;
            case 3:
              setState(() {
                currentPage = 3;
              });

              Navigator.of(context).pushReplacement(
                MaterialPageRoute(
                  builder: (context) => const ProfileScreen(),
                ),
              );
              break;
            default:
              break;
          }
        },
      ),
    );
  }
}
