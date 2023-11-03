// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:myapp/page-1/login.dart';
import 'package:myapp/services/user_service.dart';
import 'package:otp_text_field/otp_field.dart';
import 'package:otp_text_field/style.dart';

class emailVerificationPage extends StatelessWidget {
  GraphQLService userService = GraphQLService();

  void _verifyEmail(context, otp) async {
    showDialog(
      context: context,
      barrierDismissible: false, // Prevent dismissing by tapping outside
      builder: (context) {
        return Center(
          child: CircularProgressIndicator(),
        );
      },
    );
    final verified = await userService.vefifyEmail(otp: otp);

    if (verified) {
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => LoginScreen()));
    }
  }

  @override
  Widget build(BuildContext context) {
    double baseWidth = 400;
    double fem = MediaQuery.of(context).size.width / baseWidth;
    double ffem = fem * 0.97;
    return Scaffold(
      appBar: AppBar(
        systemOverlayStyle: const SystemUiOverlayStyle(
          statusBarColor: Colors.white,
          statusBarIconBrightness: Brightness.dark,
          statusBarBrightness: Brightness.light,
        ),
        elevation: 0,
        backgroundColor: Colors.white10,
        leading: IconButton(
          // Use the iOS-style back button icon
          icon: Icon(
            Icons.arrow_back_ios,
            color: const Color(0xff643600),
          ),
          onPressed: () {
            Navigator.of(context)
                .pop(); // Navigate back when the button is pressed
          },
        ),
        title: const Text(
          'Email Verification',
          style: TextStyle(color: const Color(0xff643600)),
        ),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10.0),
          child: Column(
            children: <Widget>[
              const SizedBox(height: 50),
              const Text(
                'Verify Your Email Address',
                style: TextStyle(fontSize: 20),
              ),
              const SizedBox(height: 50),
              const Text(
                  'An email with a verification link has been sent to your email address.',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w400)),
              const SizedBox(height: 40),
              const Text('Enter your OTP.',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    color: const Color(0xff643600),
                  )),
              const SizedBox(height: 20),
              OTPTextField(
                length: 6,
                width: MediaQuery.of(context).size.width,
                fieldWidth: 50,
                style: TextStyle(fontSize: 17),
                textFieldAlignment: MainAxisAlignment.spaceAround,
                fieldStyle: FieldStyle.box,
                onCompleted: (pin) {
                  _verifyEmail(context, pin);
                },
              ),
              const SizedBox(height: 30),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Text('Did\'t get any code?'),
                        TextButton(
                          onPressed: () {},
                          child: Text(
                            'Resend',
                            style: TextStyle(
                              fontFamily: 'Poppins',
                              fontSize: 15 * ffem,
                              fontWeight: FontWeight.w500,
                              height: 1.5 * ffem,
                              color: const Color(0xff643600),
                            ),
                          ),
                        ),
                      ],
                    ),
                    TextButton(
                      onPressed: () {
                        Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (context) => LoginScreen()));
                      },
                      child: Text(
                        'Login',
                        style: TextStyle(
                          fontFamily: 'Poppins',
                          fontSize: 15 * ffem,
                          fontWeight: FontWeight.w500,
                          height: 1.5 * ffem,
                          color: const Color(0xff643600),
                        ),
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
