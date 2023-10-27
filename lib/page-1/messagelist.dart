import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:myapp/page-1/ChatScreen.dart';
import 'package:myapp/page-1/ProfileScreen.dart';
import 'package:myapp/page-1/feeds/bottombar.dart';
import 'package:myapp/page-1/feeds/homescreen.dart';

class MessengerPage extends StatefulWidget {
  const MessengerPage({Key? key});

  @override
  State<MessengerPage> createState() => _MessengerPageState();
}

class _MessengerPageState extends State<MessengerPage> {
  @override
  Widget build(BuildContext context) {
    var listItem = [
      listIndividual(),
      listIndividual(),
      listIndividual(),
      listIndividual(),
      listIndividual(),
      listIndividual(),
      listIndividual(),
      listIndividual(),
    ];

    return Scaffold(
      appBar: AppBar(
        systemOverlayStyle: const SystemUiOverlayStyle(
          // Status bar color
          statusBarColor: Colors.white,
          statusBarIconBrightness: Brightness.dark, // For Android (dark icons)
          statusBarBrightness: Brightness.light, // For iOS (dark icons)
        ),
        elevation: 0,
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
              width: 45,
              height: 45,
            ),
          ),
          onPressed: () {},
        ),
        titleSpacing: 3,
        title: const Text(
          'PPSONA',
          style: TextStyle(
            color: Color.fromARGB(255, 167, 135, 135),
            decoration: TextDecoration.none,
            fontFamily: 'PermanentMarker-Regular',
            fontWeight: FontWeight.bold,
            fontSize: 25,
          ),
        ),
      ),
      body: Column(
        children: [
          const SizedBox(
            height: 10,
          ),
          const Text(
            'Your Messages',
            style: TextStyle(
              color: Color.fromARGB(255, 167, 135, 135),
              decoration: TextDecoration.none,
              fontFamily: 'PermanentMarker-Regular',
              fontWeight: FontWeight.bold,
              fontSize: 20,
            ),
          ),
          const Divider(
            color: Color.fromARGB(40, 167, 135, 135),
            height: 20,
            thickness: 3,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 15.0, right: 15),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              // children: [
              // Row(
              //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
              //   children: [
              //     const Text(
              //       'Messages',
              //       style: TextStyle(
              //           fontWeight: FontWeight.bold,
              //           fontFamily: 'Quicksand',
              //           fontSize: 30,
              //           color: Colors.white),
              //     ),
              //     IconButton(
              //       onPressed: () {},
              //       icon: const Icon(
              //         Icons.search,
              //         color: Colors.white,
              //         size: 36,
              //       ),
              //     ),
              //   ],
              // ),
              // const SizedBox(
              //   height: 5,
              // ),
              // const Text(
              //   'R E C E N T',
              //   style: TextStyle(
              //     color: Colors.white,
              //   ),
              // ),
              //  ],
            ),
          ),
          SingleChildScrollView(
            child: Column(
              children: [
                Container(
                  width: double.infinity,
                  // decoration: const BoxDecoration(
                  //   color: Color.fromARGB(255, 229, 230, 232),
                  //   borderRadius: BorderRadius.only(
                  //     topLeft: Radius.circular(50),
                  //     topRight: Radius.circular(50),
                  //   ),
                  // ),
                  child: ListView(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    children: listItem,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
      bottomNavigationBar: Bottombar(),
    );
  }

  Widget listIndividual() {
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => ChatScreen()));
      },
      child: const Padding(
        padding:
            const EdgeInsets.only(left: 26.0, top: 8, bottom: 8, right: 10),
        child: Row(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                CircleAvatar(
                  radius: 30,
                  backgroundImage:
                      AssetImage('assets/page-1/images/rectangle-688.png'),
                ),
              ],
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text(
                      'Danny Hopkins',
                      style: TextStyle(
                        color: const Color.fromARGB(255, 18, 16, 16),
                        fontFamily: 'Quicksand',
                        fontSize: 17,
                      ),
                    ),
                    SizedBox(
                      width: 100,
                    ),
                    Text(
                      '08:43',
                      style: TextStyle(
                        color: const Color.fromARGB(179, 17, 16, 16),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 5),
                Text(
                  'dannydon@gmail.com',
                  style: TextStyle(
                    color: const Color.fromARGB(179, 18, 17, 17),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
