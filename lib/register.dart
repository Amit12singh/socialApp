import 'package:flutter/material.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  double fem = 1.0; // Adjust this based on your design
  double ffem = 0.97; // Adjust this based on your design

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: EdgeInsets.fromLTRB(0, 59 * fem, 0, 0),
        width: double.infinity,
        decoration: BoxDecoration(
          color: Color(0xff643600),
        ),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              _buildHeader(ffem),
              _buildRegistrationForm(fem, ffem),
              _buildFooter(fem, ffem),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeader(double ffem) {
    return Container(
      margin: EdgeInsets.fromLTRB(0, 0, 0, 23 * ffem),
      child: Text(
        'Register Account',
        textAlign: TextAlign.center,
        style: TextStyle(
          fontFamily: 'Poppins',
          fontSize: 18 * ffem,
          fontWeight: FontWeight.w700,
          height: 1.5 * ffem,
          color: Color(0xffffffff),
        ),
      ),
    );
  }

  Widget _buildRegistrationForm(double fem, double ffem) {
    return Container(
      padding: EdgeInsets.fromLTRB(16.33 * fem, 20.5 * fem, 21 * fem, 63 * fem),
      width: double.infinity,
      height: 746 * fem,
      decoration: BoxDecoration(
        color: Color(0xffffffff),
        borderRadius: BorderRadius.circular(33 * fem),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // Add your form fields here
          _buildFormField(
            labelText: 'Enter your full name',
            hintStyle: TextStyle(
              fontFamily: 'Poppins',
              fontSize: 15.0, // Adjust as needed
              fontWeight: FontWeight.w500,
              color: Color.fromARGB(255, 14, 21, 93),
            ),
          ),
          _buildFormField(
            labelText: 'Enter your email address',
            hintStyle: TextStyle(
              fontFamily: 'Poppins',
              fontSize: 15.0, // Adjust as needed
              fontWeight: FontWeight.w500,
              color: Color(0xffdadbd8),
            ),
          ),
          _buildFormField(
            labelText: 'Enter password',
            hintStyle: TextStyle(
              fontFamily: 'Poppins',
              fontSize: 15.0, // Adjust as needed
              fontWeight: FontWeight.w500,
              color: Color(0xffdadbd8),
            ),
          ),
          _buildFormField(
            labelText: 'Enter Confirm password',
            hintStyle: TextStyle(
              fontFamily: 'Poppins',
              fontSize: 15.0, // Adjust as needed
              fontWeight: FontWeight.w500,
              color: Color(0xffdadbd8),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFormField({
    required String labelText,
    required TextStyle hintStyle,
  }) {
    return Container(
      margin: EdgeInsets.fromLTRB(0, 0, 5.67 * fem, 18.33 * fem),
      padding: EdgeInsets.fromLTRB(
          16.17 * fem, 16.5 * fem, 130.33 * fem, 18.5 * fem),
      width: double.infinity,
      height: 58 * fem,
      decoration: BoxDecoration(
        color: Color(0xfff9f9f9),
        borderRadius: BorderRadius.circular(16 * fem),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            margin: EdgeInsets.fromLTRB(0, 2, 17.5, 0),
            width: 16,
            height: 18,
            child: Icon(
              Icons.message,
              size: 16,
              color: Colors.black,
            ),
          ),
          Container(
            width: 152,
            height: double.infinity,
            child: Center(
              child: TextFormField(
                decoration: InputDecoration(
                  labelText: labelText,
                  hintStyle: hintStyle,
                ),
                textAlign: TextAlign.center,
                style: hintStyle.copyWith(fontSize: 15.0), // Adjust as needed
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFooter(double fem, double ffem) {
    return Container(
      margin: EdgeInsets.fromLTRB(54.42 * fem, 0, 56 * fem, 52.68 * fem),
      width: double.infinity,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            margin: EdgeInsets.fromLTRB(0, 0, 5.25 * fem, 0),
            child: Text(
              'Already have an account?',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontFamily: 'Poppins',
                fontSize: 14 * ffem,
                fontWeight: FontWeight.w500,
                height: 1.5 * ffem,
                color: Color(0xff3e402d),
              ),
            ),
          ),
          TextButton(
            onPressed: () {},
            style: TextButton.styleFrom(
              padding: EdgeInsets.zero,
            ),
            child: Text(
              'Log in',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontFamily: 'Poppins',
                fontSize: 12 * ffem,
                fontWeight: FontWeight.w500,
                height: 1.5 * ffem,
                color: Color(0xff643600),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
