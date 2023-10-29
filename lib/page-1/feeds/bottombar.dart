import 'package:flutter/material.dart';
import 'package:myapp/page-1/SearchPage.dart';
import 'package:myapp/page-1/messagelist.dart';
import 'package:myapp/page-1/ProfileScreen.dart';
import 'package:myapp/page-1/feeds/homescreen.dart';

class Bottombar extends StatelessWidget {
  const Bottombar({Key? key}) : super(key: key);

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
          if (index == 3) {
            Navigator.of(context).pushReplacement(
              MaterialPageRoute(
                builder: (context) => const ProfileScreen(),
              ),
            );
          } else if (index == 0) {
            Navigator.of(context).pushReplacement(
              MaterialPageRoute(
                builder: (context) => FeedScreen(),
              ),
            );
          } else if (index == 1) {
            Navigator.of(context).pushReplacement(
              MaterialPageRoute(
                builder: (context) => SearchPage(),
              ),
            );
          } else if (index == 2) {
            Navigator.of(context).pushReplacement(
              MaterialPageRoute(
                builder: (context) => MessengerPage(),
              ),
            );
          }
        },
      ),
    );
  }
}
