import 'package:flutter/material.dart';

import 'package:myapp/page-1/feeds/homescreen.dart';
import 'package:page_transition/page_transition.dart';

class BatchMatePage extends StatelessWidget {
  const BatchMatePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar(context),
      body: listView(),
      bottomNavigationBar: bottom(context),
    );
  }

  PreferredSizeWidget appBar(BuildContext context) {
    return AppBar(
      backgroundColor: const Color.fromARGB(255, 167, 135, 135),
      title: const Text(
        'YOUR NABHAITES',
        style: TextStyle(color: Colors.black),
      ),
      centerTitle: true,
      automaticallyImplyLeading: false,
    );
  }

  Widget listView() {
    return GridView.builder(
      gridDelegate:
          const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3),
      itemCount: 21,
      itemBuilder: (context, index) {
        return ListViewItem(index);
      },
    );
  }

  Widget ListViewItem(int index) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            width: 67,
            height: 67,
            padding: const EdgeInsets.all(4.0),
            decoration: const BoxDecoration(
                shape: BoxShape.circle,
                gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [Color(0xFF982282), Color(0xFFEEA863)])),
            child: Container(
              width: 65,
              height: 65,
              decoration: const BoxDecoration(
                color: Colors.white,
                shape: BoxShape.circle,
              ),
              child: Padding(
                padding: const EdgeInsets.all(4.0),
                child: Container(
                  width: 65,
                  height: 65,
                  decoration: const BoxDecoration(
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey,
                          spreadRadius: 1,
                        ),
                      ],
                      shape: BoxShape.circle,
                      image: DecorationImage(
                          image: AssetImage(
                              'assets/page-1/images/rectangle-688.png'))),
                ),
              ),
            ),
          ),
        ),
        const SizedBox(height: 4),
        const Text(
          'Hari Shyam',
          style: TextStyle(
            color: Colors.black,
            fontSize: 14,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }

  Widget bottom(BuildContext context) {
    return MaterialButton(
      onPressed: () async {
        await Navigator.of(context).pushReplacement(
          PageTransition(
            type: PageTransitionType.scale,
            alignment: Alignment.bottomCenter,
            child: FeedScreen(),
          ),
        );
      },
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      child: Container(
        width: 500,
        height: 65,
        decoration: BoxDecoration(
          color: const Color(0xff643600),
          borderRadius: BorderRadius.circular(16),
        ),
        child: const Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Let's get started",
              style: TextStyle(
                fontFamily: 'Poppins',
                fontSize: 18,
                fontWeight: FontWeight.w700,
                height: 1.5,
                color: const Color(0xffffffff),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
