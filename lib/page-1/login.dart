import 'package:flutter/material.dart';
import 'package:myapp/page-1/feeds/homescreen.dart';
import 'package:myapp/register.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  bool _isValidEmail(String email) {
    final RegExp emailRegExp =
        RegExp(r'^[\w-]+(\.[\w-]+)*@([\w-]+\.)+[a-zA-Z]{2,7}$');
    return emailRegExp.hasMatch(email);
  }

  String _email = "";
  String _password = "";
  bool _isPasswordVisible = false;

  @override
  Widget build(BuildContext context) {
    double baseWidth = 375;
    double fem = MediaQuery.of(context).size.width / baseWidth;
    double ffem = fem * 0.97;

    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
          color: Color(0xff643600),
        ),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(height: 70 * fem),
              Text(
                'Login to your account',
                style: TextStyle(
                  fontFamily: 'Poppins',
                  fontSize: 18 * ffem,
                  fontWeight: FontWeight.w700,
                  height: 1.5 * ffem,
                  color: Color(0xffffffff),
                ),
              ),
              SizedBox(height: 30 * fem),
              Container(
                padding: EdgeInsets.symmetric(
                  horizontal: 16.33 * fem,
                  vertical: 63 * fem,
                ),
                width: 375 * fem,
                decoration: BoxDecoration(
                  color: Color(0xffffffff),
                  borderRadius: BorderRadius.circular(33 * fem),
                ),
                child: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        'Welcome back!',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontFamily: 'Poppins',
                          fontSize: 30 * ffem,
                          fontWeight: FontWeight.w700,
                          height: 1.5 * ffem,
                          color: Color(0xff000000),
                        ),
                      ),
                      SizedBox(height: 40 * fem),
                      Container(
                        margin: EdgeInsets.only(bottom: 18.33 * fem),
                        padding: EdgeInsets.fromLTRB(
                          14.23 * fem,
                          17.5 * fem,
                          16.17 * fem,
                          17.5 * fem,
                        ),
                        decoration: BoxDecoration(
                          color: Color(0xfff9f9f9),
                          borderRadius: BorderRadius.circular(16 * fem),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            children: [
                              Icon(
                                Icons.inbox,
                                size: 16 * fem,
                              ),
                              SizedBox(width: 17.5 * fem),
                              Expanded(
                                child: TextFormField(
                                  decoration: InputDecoration(
                                    hintText: 'Enter Email',
                                    hintStyle: TextStyle(
                                      fontFamily: 'Poppins',
                                      fontSize: 15 * ffem,
                                      fontWeight: FontWeight.w500,
                                      height: 1.5 * ffem,
                                      color: Color(0xffdadbd8),
                                    ),
                                  ),
                                  validator: (value) {
                                    if (value!.isEmpty) {
                                      return 'Email is required';
                                    } else if (!_isValidEmail(value)) {
                                      return 'Enter a valid email';
                                    }
                                    return null;
                                  },
                                  onSaved: (value) {
                                    _email = value!;
                                  },
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(height: 25 * fem),
                      Container(
                        margin: EdgeInsets.only(bottom: 60.02 * fem),
                        padding: EdgeInsets.fromLTRB(
                          16.17 * fem,
                          17.5 * fem,
                          27.81 * fem,
                          17.5 * fem,
                        ),
                        decoration: BoxDecoration(
                          color: Color(0xfff9f9f9),
                          borderRadius: BorderRadius.circular(16 * fem),
                        ),
                        child: Row(
                          children: [
                            Icon(
                              Icons.lock,
                              size: 16 * fem,
                            ),
                            SizedBox(width: 15 * fem),
                            Expanded(
                              child: TextFormField(
                                decoration: InputDecoration(
                                  hintText: 'Enter password',
                                  hintStyle: TextStyle(
                                    fontFamily: 'Poppins',
                                    fontSize: 15 * ffem,
                                    fontWeight: FontWeight.w500,
                                    height: 1.5 * ffem,
                                    color: Color(0xffdadbd8),
                                  ),
                                ),
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return 'Password is required';
                                  }
                                  return null;
                                },
                                onSaved: (value) {
                                  _password = value!;
                                },
                                obscureText:
                                    !_isPasswordVisible, // Toggle password visibility
                              ),
                            ),
                            SizedBox(width: 17.5 * fem),
                            GestureDetector(
                              onTap: () {
                                setState(() {
                                  _isPasswordVisible = !_isPasswordVisible;
                                });
                              },
                              child: Icon(
                                _isPasswordVisible
                                    ? Icons.visibility
                                    : Icons.visibility_off,
                                size: 22 * fem,
                                color: _isPasswordVisible
                                    ? Colors.blue
                                    : Colors.grey, // Customize the color
                              ),
                            ),
                          ],
                        ),
                      ),
                      Row(
                        children: [
                          Container(
                            width: 13 * fem,
                            height: 13 * fem,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(2 * fem),
                              border: Border.all(color: Color(0xffd9d9d9)),
                            ),
                          ),
                          SizedBox(width: 10.43 * fem),
                          Text(
                            'Remember me',
                            style: TextStyle(
                              fontFamily: 'Poppins',
                              fontSize: 12 * ffem,
                              fontWeight: FontWeight.w500,
                              height: 1.5 * ffem,
                              color: Color(0xffcccdca),
                            ),
                          ),
                          Spacer(),
                          TextButton(
                            onPressed: () {
                              // Implement your "Forget Your Password?" logic here
                            },
                            style: TextButton.styleFrom(
                              padding: EdgeInsets.zero,
                            ),
                            child: Text(
                              'Forget Your Password?',
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
                      SizedBox(height: 30 * fem),
                      TextButton(
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {
                            _formKey.currentState!.save();

                            print('Email: $_email');
                            print('Password: $_password');

                            Navigator.of(context).pushReplacement(
                              MaterialPageRoute(
                                builder: (context) => FeedScreen(),
                              ),
                            );
                          }
                        },
                        style: TextButton.styleFrom(
                          padding: EdgeInsets.zero,
                        ),
                        child: Container(
                          width: 332 * fem,
                          height: 58 * fem,
                          decoration: BoxDecoration(
                            color: Color(0xff643600),
                            borderRadius: BorderRadius.circular(16 * fem),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment
                                .center, // Center both elements horizontally
                            children: [
                              Text(
                                'Login',
                                style: TextStyle(
                                  fontFamily: 'Poppins',
                                  fontSize: 18 * ffem,
                                  fontWeight: FontWeight.w700,
                                  height: 1.5 * ffem,
                                  color: Color(0xffffffff),
                                ),
                              ),
                              SizedBox(
                                  width: 5 *
                                      fem), // Add some spacing between text and icon
                              Icon(
                                Icons.login,
                                size: 17.98 * fem,
                              ),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(height: 30 * fem),
                      Text(
                        'Don’t have an account?',
                        style: TextStyle(
                          fontFamily: 'Poppins',
                          fontSize: 12 * ffem,
                          fontWeight: FontWeight.w500,
                          height: 1.5 * ffem,
                          color: Color(0xffcccdca),
                        ),
                      ),
                      TextButton(
                        onPressed: () {
                          // Navigate to RegisterScreen when the "Register Now" button is pressed
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) =>
                                  RegisterScreen(), // Replace RegisterScreen with your actual register screen widget
                            ),
                          );
                        },
                        style: TextButton.styleFrom(
                          padding: EdgeInsets.zero,
                        ),
                        child: Text(
                          'Register Now',
                          style: TextStyle(
                            fontFamily: 'Poppins',
                            fontSize: 12 * ffem,
                            fontWeight: FontWeight.w500,
                            height: 1.5 * ffem,
                            color: Color(0xff643600),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
