import 'package:flutter/material.dart';
import 'package:myapp/page-1/feeds/homescreen.dart';
import 'package:myapp/page-1/feeds/post.dart';
import 'dart:ui';
import 'package:myapp/page-1/login.dart';
import 'package:myapp/register.dart';
import 'package:myapp/utilities/localstorage.dart';

class Onboarding extends StatefulWidget {
  @override
  _OnboardingState createState() => _OnboardingState();
}

class _OnboardingState extends State<Onboarding> {
  @override
  Widget build(BuildContext context) {
    double baseWidth = 380;
    double fem = MediaQuery.of(context).size.width / baseWidth;
    double ffem = fem * 0.97;
    return Scaffold(
      appBar: null,
      backgroundColor: Color(0xff643600),
      resizeToAvoidBottomInset: false,
      body: Container(
        width: double.infinity,
        height: double.infinity,
        padding: EdgeInsets.zero,
        margin: EdgeInsets.zero,
        decoration: BoxDecoration(
            // image: DecorationImage(
            //   image: AssetImage('assets/your_decorative_line.png'),
            //   fit: BoxFit.cover,
            // ),
            ),
        child: Stack(
          children: [
            Positioned(
              left: 25 * fem,
              top: 670 * fem,
              child: TextButton(
                onPressed: () {
                  Navigator.of(context).pushReplacement(
                    MaterialPageRoute(builder: (context) => LoginScreen()),
                  );
                },
                style: TextButton.styleFrom(
                  padding: EdgeInsets.zero,
                ),
                child: Container(
                  width: 325 * fem,
                  height: 56 * fem,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(45 * fem),
                    image: const DecorationImage(
                      fit: BoxFit.cover,
                      image: AssetImage(
                        'assets/page-1/images/rectangle-1.png',
                      ),
                    ),
                  ),
                  child: Center(
                    child: Text(
                      'Get Started',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontFamily: 'Poppins',
                        fontSize: 16 * ffem,
                        fontWeight: FontWeight.w400,
                        height: 1.5 * ffem / fem,
                        letterSpacing: 0.32 * fem,
                        color: const Color(0xff643600),
                      ),
                    ),
                  ),
                ),
              ),
            ),
            Positioned(
              left: 319 * fem,
              top: 40 * fem,
              child: Align(
                child: TextButton(
                  onPressed: () {
                    Navigator.of(context).pushReplacement(
                      MaterialPageRoute(builder: (context) => LoginScreen()),
                    );
                  },
                  child: Text(
                    'SKIP',
                    style: TextStyle(
                      fontFamily: 'Work Sans',
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      letterSpacing: 0.28 * fem,
                      color: const Color(0xffffffff),
                      decoration: TextDecoration.none,
                    ),
                  ),
                ),
              ),
            ),

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
            // Positioned(
            //   left: 53.5 * fem,
            //   top: 741 * fem,
            //   child: Align(
            //     child: SizedBox(
            //       width: 174 * fem,
            //       height: 26 * fem,
            //       child: Text(
            //         'Dont have an account? ',
            //         textAlign: TextAlign.center,
            //         style: TextStyle(
            //           fontFamily: 'Poppins',
            //           fontSize: 14 * ffem,
            //           fontWeight: FontWeight.w500,
            //           height: 1.8571428571 * ffem / fem,
            //           letterSpacing: 0.28 * fem,
            //           color: const Color(0xccffffff),
            //           decoration: TextDecoration.none,
            //         ),
            //       ),
            //     ),
            //   ),
            // ),
            // Positioned(
            //   left: 210.75 * fem,
            //   top: 741 * fem,
            //   child: Align(
            //     child: SizedBox(
            //       width: 94 * fem,
            //       height: 26 * fem,
            //       child: TextButton(
            //         onPressed: () {
            //           Navigator.pushReplacement(
            //             context,
            //             MaterialPageRoute(
            //               builder: (context) => RegisterScreen(),
            //             ),
            //           );
            //         },
            //         style: TextButton.styleFrom(
            //           padding: EdgeInsets.zero,
            //         ),
            //         child: Text(
            //           'Register now',
            //           textAlign: TextAlign.center,
            //           style: TextStyle(
            //             fontFamily: 'Poppins',
            //             fontSize: 14 * ffem,
            //             fontWeight: FontWeight.w500,
            //             height: 1.8571428571 * ffem / fem,
            //             letterSpacing: 0.28 * fem,
            //             color: const Color(0xccffffff),
            //           ),
            //         ),
            //       ),
            //     ),
            //   ),
            // ),
          ],
        ),
      ),
    );
  }
}
