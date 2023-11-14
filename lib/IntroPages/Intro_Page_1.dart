import 'package:flutter/material.dart';

class IntroPage1 extends StatelessWidget {
  const IntroPage1({super.key});

  @override
  Widget build(BuildContext context) {
    double baseWidth = 380;
    double fem = MediaQuery.of(context).size.width / baseWidth;
    double ffem = fem * 0.97;

    return Scaffold(
      backgroundColor: Color.fromARGB(255, 167, 135, 135),
      body: Container(
        child: Stack(
          children: [
            Positioned(
              left: 39.5 * fem,
              top: 150 * fem,
              child: Container(
                width: 296 * fem,
                height: 152 * fem,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      margin: EdgeInsets.fromLTRB(
                          0 * fem, 0 * fem, 0 * fem, 10 * fem),
                      constraints: BoxConstraints(
                        maxWidth: 255 * fem,
                      ),
                      child: Text(
                        'FIND YOUR OLD\nNABHAITES ',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontFamily: 'Poppins',
                          fontSize: 35 * ffem,
                          fontWeight: FontWeight.w400,
                          height: 1.2857142857 * ffem / fem,
                          color: const Color(0xffffffff),
                          decoration: TextDecoration.none,
                        ),
                      ),
                    ),
                    Container(
                      constraints: BoxConstraints(
                        maxWidth: 296 * fem,
                      ),
                      child: Text(
                        'Enjoy together, happy to share and save your message with your old friends.',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontFamily: 'Poppins',
                          fontSize: 14 * ffem,
                          fontWeight: FontWeight.w500,
                          height: 1.8571428571 * ffem / fem,
                          letterSpacing: 0.28 * fem,
                          color: const Color(0xccffffff),
                          decoration: TextDecoration.none,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
