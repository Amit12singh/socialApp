import 'package:flutter/material.dart';
import 'package:ppsona/pages/LoginScreen.dart';
import 'package:ppsona/pages/SplashScreen.dart';
import 'package:ppsona/utilities/Utils.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'PPSONA',
        debugShowCheckedModeBanner: false,
        scrollBehavior: MyCustomScrollBehavior(),
        theme: ThemeData(
            errorColor: Colors.red,
            primaryColor: Color.fromARGB(255, 167, 135, 135)),
        home: Scaffold(
          body: SingleChildScrollView(
            child: SplashScreen(),
          ),
        ),
        routes: {
          '/login': (context) => LoginScreen(),
        });
  }
}
