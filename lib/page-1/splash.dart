import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:myapp/page-1/feeds/homescreen.dart';
import 'dart:async';
import 'package:myapp/page-1/onboarding.dart';
import 'package:myapp/utilities/localstorage.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  final HandleToken localStorageService = HandleToken();
  @override
  void initState() {
    super.initState();

    Timer(const Duration(seconds: 3), () async {
      if (await localStorageService.isUserLoggedIn()) {
        Navigator.of(context).pushReplacement(
            MaterialPageRoute(builder: (context) => const FeedScreen()));
      } else {
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (BuildContext context) => Onboarding()),
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    double baseWidth = 375;
    double fem = MediaQuery.of(context).size.width / baseWidth;

    return Scaffold(
      appBar: AppBar(
        systemOverlayStyle: const SystemUiOverlayStyle(
          // Status bar color
          statusBarColor: Color(0xffd9d9d9),
          statusBarIconBrightness: Brightness.dark, // For Android (dark icons)
          statusBarBrightness: Brightness.light, // For iOS (dark icons)
        ),
        elevation: 0,
        backgroundColor: Colors.white,
      ),
      body: Container(
        width: double.infinity,
        child: Container(
          padding: EdgeInsets.fromLTRB(
              68.67 * fem, 301.53 * fem, 68.67 * fem, 301.53 * fem),
          width: double.infinity,
          height: 812 * fem,
          decoration: const BoxDecoration(
            color: Color(0xffd9d9d9),
          ),
          child: Center(
            child: SizedBox(
              width: 237.65 * fem,
              height: 208.94 * fem,
              child: Image.asset(
                'assets/page-1/images/logo-3-removebg-preview-1.png',
                fit: BoxFit.cover,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
