import 'package:flutter/material.dart';
import 'package:myapp/page-1/ChatScreen.dart';
import 'package:myapp/page-1/feeds/bottombar.dart';

class MessengerPage extends StatefulWidget {
  const MessengerPage({Key? key});

  @override
  State<MessengerPage> createState() => _MessengerPageState();
}

class _MessengerPageState extends State<MessengerPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 224, 170, 23),
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 15.0, right: 15),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Messages',
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontFamily: 'Quicksand',
                            fontSize: 30,
                            color: Colors.white),
                      ),
                      IconButton(
                        onPressed: () {},
                        icon: Icon(
                          Icons.search,
                          color: Colors.white,
                          size: 36,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Text(
                    'R E C E N T',
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Container(
              height: 645.6,
              width: double.infinity,
              decoration: BoxDecoration(
                color: Color.fromARGB(255, 229, 230, 232),
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(50),
                  topRight: Radius.circular(50),
                ),
              ),
              child: ListView(
                children: [
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => ChatScreen()));
                    },
                    child: Padding(
                      padding:
                          const EdgeInsets.only(left: 26.0, top: 35, right: 10),
                      child: Row(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              CircleAvatar(
                                radius: 30,
                                backgroundImage: AssetImage(
                                    'assets/page-1/images/rectangle-688.png'),
                              ),
                            ],
                          ),
                          SizedBox(width: 10),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Text(
                                    'Danny Hopkins',
                                    style: TextStyle(
                                      color:
                                          const Color.fromARGB(255, 18, 16, 16),
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
                                      color:
                                          const Color.fromARGB(179, 17, 16, 16),
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
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: Bottombar(),
    );
  }
}
