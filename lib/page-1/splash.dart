import 'package:flutter/material.dart';
import 'package:myapp/page-1/feeds/homescreen.dart';
import 'package:myapp/page-1/login.dart';
import 'dart:async';
import 'package:myapp/page-1/onboarding.dart';
import 'package:myapp/utilities/localstorage.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:page_transition/page_transition.dart';

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
      if (await localStorageService.showOnboarding()) {
        Navigator.of(context).pushReplacement(
          PageTransition(
            type: PageTransitionType.scale,
            alignment: Alignment.bottomCenter,
            child: onboardingScreen(),
          ),
        );
        _load();
      } else {
        if (await localStorageService.isUserLoggedIn()) {
          Navigator.of(context).pushReplacement(
            PageTransition(
              type: PageTransitionType.scale,
              alignment: Alignment.bottomCenter,
              child: FeedScreen(),
            ),
          );
        } else {
          Navigator.of(context).pushReplacement(
            PageTransition(
              type: PageTransitionType.scale,
              alignment: Alignment.bottomCenter,
              child: LoginScreen(),
            ),
          );
        }
      }
    });
  }

  void _load() async {
    const storage = FlutterSecureStorage();
    await storage.write(key: 'isFirstTime', value: "false");
  }

  @override
  Widget build(BuildContext context) {
    double baseWidth = 375;
    double fem = MediaQuery.of(context).size.width / baseWidth;

    return Container(
      padding: EdgeInsets.fromLTRB(
          68.67 * fem, 301.53 * fem, 68.67 * fem, 301.53 * fem),
      decoration: const BoxDecoration(
        color: Color(0xffd9d9d9),
      ),
      child: Center(
        child: Image.asset(
          'assets/page-1/images/logo-3-removebg-preview-1.png',
          fit: BoxFit.cover,
          width: 200,
          height: 200,
        ),
      ),
    );
  }
}
