import 'package:flutter/material.dart';

class Bottombar extends StatelessWidget {
  const Bottombar({super.key});

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
            icon: Icon(Icons.favorite_outline_rounded), label: 'heart'),
        BottomNavigationBarItem(
            icon: CircleAvatar(
              backgroundColor: Colors.white,
              backgroundImage:
                  AssetImage('assets/page-1/images/vector-AZF.png'),
            ),
            label: 'User'),
      ],
    ));
  }
}
