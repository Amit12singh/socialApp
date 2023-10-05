import 'package:flutter/material.dart';
import 'dart:ui';
import 'package:myapp/page-1/feeds/bottombar.dart';
import 'package:myapp/page-1/feeds/post.dart';

class FeedScreen extends StatefulWidget {
  const FeedScreen({super.key});

  @override
  State<FeedScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<FeedScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: Icon(
          Icons.camera_alt_outlined,
          size: 40,
          color: Colors.grey[600],
        ),
        titleSpacing: 3,
        title: Text(
          'PPSONA',
          style: TextStyle(
            color: Colors.black,
            decoration: TextDecoration.none,
            fontFamily: 'Billabong',
            fontSize: 30,
          ),
        ),
        actions: [
          IconButton(
              icon: Icon(
                Icons.search,
                size: 35,
                color: Colors.black,
              ),
              onPressed: () {}),
          // IconButton(
          //   icon: Image.asset(
          //     'tabler-photo-plus.png',
          //   ),
          //   onPressed: () {},
          // ),
        ],
      ),
      body: Column(
        children: [Expanded(child: PostScreen())],
      ),
      bottomNavigationBar: Bottombar(),
    );
  }
}
