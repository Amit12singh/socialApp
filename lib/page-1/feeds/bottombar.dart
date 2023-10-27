import 'package:flutter/material.dart';
import 'package:myapp/page-1/messagelist.dart';
import 'package:myapp/page-1/ProfileScreen.dart';
import 'package:myapp/page-1/feeds/homescreen.dart';

class Bottombar extends StatelessWidget {
  const Bottombar({Key? key});

  @override
  Widget build(BuildContext context) {
    return BottomAppBar(
      child: BottomNavigationBar(
        elevation: 8.0,
        type: BottomNavigationBarType.fixed,
        selectedItemColor: Colors.black,
        showSelectedLabels: false,
        showUnselectedLabels: false,
        selectedFontSize: 8.0,
        iconSize: 25,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'home'),
          BottomNavigationBarItem(
            icon: Icon(Icons.message),
            label: 'message',
          ),
          BottomNavigationBarItem(
            icon: CircleAvatar(
              backgroundColor: Colors.white,
              child: Image(
                image: AssetImage('assets/page-1/images/man.png'),
                width: 20.0,
                height: 20.0,
              ),
            ),
            label: 'User',
          )
        ],
        onTap: (int index) {
          if (index == 2) {
            Navigator.of(context).pushReplacement(
              MaterialPageRoute(
                builder: (context) => const ProfileScreen(),
              ),
            );
          } else if (index == 0) {
            Navigator.of(context).pushReplacement(
              MaterialPageRoute(
                builder: (context) => const FeedScreen(),
              ),
            );
          } else if (index == 1) {
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
