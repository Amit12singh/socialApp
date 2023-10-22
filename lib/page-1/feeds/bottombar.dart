import 'package:flutter/material.dart';
import 'package:myapp/page-1/MessengerPage.dart';
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
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'home'),
          // BottomNavigationBarItem(icon: Icon(Icons.message), label: 'message'),
          // BottomNavigationBarItem(icon: Icon(Icons.add), label: 'add'),
          BottomNavigationBarItem(
            icon: Icon(Icons.message),
            label: 'message',
          ),
          BottomNavigationBarItem(
            icon: CircleAvatar(
              backgroundColor: Colors.white,
              child: Image(
                image: AssetImage('assets/page-1/images/vector-AZF.png'),
                width: 20.0, // Set the width to the desired size
                height: 20.0, // Set the height to the desired size
              ),
            ),
            label: 'User',
          )
        ],
        // ignore: curly_braces_in_flow_control_structures
        onTap: (int index) {
          if (index == 2) {
            // Check if the button at index 2 is tapped
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => ProfileScreen(
                  user: {},
                ),
              ),
            );
          } else if (index == 0) {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => FeedScreen(),
              ),
            );
          } else if (index == 1) {
            Navigator.of(context).push(
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
