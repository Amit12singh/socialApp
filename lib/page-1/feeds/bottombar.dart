import 'package:flutter/material.dart';
import 'package:myapp/page-1/ProfileScreen.dart';
import 'package:myapp/page-1/createpostScreen.dart';

class Bottombar extends StatelessWidget {
  const Bottombar({Key? key});

  @override
  Widget build(BuildContext context) {
    return BottomAppBar(
      child: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        selectedItemColor: Colors.black,
        showSelectedLabels: false,
        showUnselectedLabels: false,
        iconSize: 35,
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'home'),
          BottomNavigationBarItem(icon: Icon(Icons.search), label: 'search'),
          BottomNavigationBarItem(icon: Icon(Icons.add), label: 'add'),
          BottomNavigationBarItem(
            icon: Icon(Icons.favorite_outline_rounded),
            label: 'heart',
          ),
          BottomNavigationBarItem(
            icon: CircleAvatar(
              backgroundColor: Colors.white,
              backgroundImage:
                  AssetImage('assets/page-1/images/vector-AZF.png'),
            ),
            label: 'User',
          ),
        ],
        onTap: (int index) {
          if (index == 2) {
            // Check if 'add' button is tapped (index 2)
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => CreatePostScreen(),
              ),
            );
          } else if (index == 4) {
            // Check if 'User' button is tapped (index 4)
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => ProfileScreen(),
              ),
            );
          }
        },
      ),
    );
  }
}
