import 'package:flutter/material.dart';
import 'package:myapp/utils.dart';
import 'package:myapp/page-1/splash.dart';




void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter',
      debugShowCheckedModeBanner: false,
      scrollBehavior: MyCustomScrollBehavior(),
      
      theme: ThemeData(
        errorColor: Colors.red,
      ),
      home: Scaffold(
        body: SingleChildScrollView(
          child: SplashScreen(),
        ),
      ),
    );
  }
}
