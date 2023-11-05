import 'package:flutter/material.dart';
import 'package:myapp/models/response_model.dart';
import 'package:myapp/page-1/feeds/homescreen.dart';
import 'package:myapp/page-1/forgetPassword.dart';
import 'package:myapp/register.dart';
import 'package:myapp/services/user_service.dart';
import 'package:page_transition/page_transition.dart';
import 'package:myapp/widgets/emailInputPage.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final GraphQLService _graphQLService = GraphQLService();
  bool rememberMe = false;

  bool _loggedIn = false;
  bool _loading = false;

  bool _isValidEmail(String email) {
    final RegExp emailRegExp =
        RegExp(r'^[\w-]+(\.[\w-]+)*@([\w-]+\.)+[a-zA-Z]{2,7}$');
    return emailRegExp.hasMatch(email);
  }

  Future<bool> forgotPassword(String email) async {
    print(email);

    BoolResponseModel response =
        await _graphQLService.forgotPassword(email: email);
    print(response);
    if (response.success) {
      return true;
    } else {
      return false;
    }
  }

  String _email = "";
  String _password = "";
  bool _isPasswordVisible = false;

  @override
  Widget build(BuildContext context) {
    double baseWidth = 400;
    double fem = MediaQuery.of(context).size.width / baseWidth;
    double ffem = fem * 0.97;

    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
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
                  color: const Color(0xffffffff),
                ),
              ),
              SizedBox(height: 20 * fem),
              Container(
                padding: EdgeInsets.symmetric(
                  horizontal: 20.33 * fem,
                  vertical: 50 * fem,
                ),
                width: 375 * fem,
                decoration: BoxDecoration(
                  color: const Color(0xffffffff),
                  borderRadius: BorderRadius.circular(33 * fem),
                ),
                child: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(height: 30 * fem),
                      Text(
                        'Welcome back!',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontFamily: 'Poppins',
                          fontSize: 30 * ffem,
                          fontWeight: FontWeight.w700,
                          height: 1.5 * ffem,
                          color: const Color(0xff000000),
                        ),
                      ),
                      SizedBox(height: 30 * fem),
                      Container(
                        margin: EdgeInsets.only(bottom: 10 * fem),
                        padding: EdgeInsets.fromLTRB(
                          10.23 * fem,
                          10.5 * fem,
                          16.17 * fem,
                          10.5 * fem,
                        ),
                        decoration: BoxDecoration(
                          color: const Color(0xfff9f9f9),
                          borderRadius: BorderRadius.circular(20 * fem),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(5.0),
                          child: Row(
                            children: [
                              Icon(
                                Icons.email_rounded,
                                size: 25 * fem,
                              ),
                              SizedBox(width: 15 * fem),
                              Expanded(
                                child: TextFormField(
                                  decoration: InputDecoration(
                                    hintText: 'Enter Email',
                                    hintStyle: TextStyle(
                                      fontFamily: 'Poppins',
                                      fontSize: 15 * ffem,
                                      fontWeight: FontWeight.w500,
                                      height: 1.5 * ffem,
                                      color: const Color(0xffdadbd8),
                                    ),
                                  ),
                                  validator: (value) {
                                    if (value!.isEmpty) {
                                      return 'Email is required';
                                    } else if (_isValidEmail(value) == false) {
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
                      SizedBox(height: 30 * fem),
                      Container(
                        margin: EdgeInsets.only(bottom: 10 * fem),
                        padding: EdgeInsets.fromLTRB(
                          10.23 * fem,
                          10.5 * fem,
                          16.17 * fem,
                          10.5 * fem,
                        ),
                        decoration: BoxDecoration(
                          color: const Color(0xfff9f9f9),
                          borderRadius: BorderRadius.circular(20 * fem),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            children: [
                              Icon(
                                Icons.lock,
                                size: 25 * fem,
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
                                      color: const Color(0xffdadbd8),
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
                                  obscureText: !_isPasswordVisible,
                                ),
                              ),
                              SizedBox(width: 0.5 * fem),
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
                                  size: 25 * fem,
                                  color: _isPasswordVisible
                                      ? Colors.blue
                                      : Colors.grey,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(height: 30 * fem),
                      Row(
                        children: [
                          GestureDetector(
                            onTap: () {
                              setState(() {
                                rememberMe = !rememberMe;
                              });
                            },
                            child: Row(
                              children: [
                                Checkbox(
                                  value: rememberMe,
                                  onChanged: (newValue) {
                                    setState(() {
                                      rememberMe = newValue!;
                                    });
                                  },
                                ),
                                SizedBox(width: 0.5 * fem),
                                Text(
                                  'Remember me',
                                  style: TextStyle(
                                    fontFamily: 'Poppins',
                                    fontSize: 12 * ffem,
                                    fontWeight: FontWeight.w500,
                                    height: 1.5 * ffem,
                                    color:
                                        const Color.fromARGB(255, 83, 65, 76),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const Spacer(),
                          TextButton(
                            onPressed: () {
                              Navigator.of(context).push(
                                PageTransition(
                                  type: PageTransitionType.scale,
                                  alignment: Alignment.bottomCenter,
                                  child: emailInputPage(
                                      title: "Forgot password",
                                      onTap: forgotPassword),
                                ),
                              );
                            },
                            style: TextButton.styleFrom(
                              padding: EdgeInsets.zero,
                            ),
                            child: Text(
                              'Forgot Password?',
                              style: TextStyle(
                                fontFamily: 'Poppins',
                                fontSize: 12 * ffem,
                                fontWeight: FontWeight.w500,
                                height: 1.5 * ffem,
                                color: const Color(0xff643600),
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 30 * fem),
                      MaterialButton(
                        onPressed: () async {
                          if (_formKey.currentState!.validate()) {
                            _formKey.currentState!.save();

                            _loading = true;

                            final isLogedin = await _graphQLService.login(
                                email: _email,
                                password: _password,
                                context: context);
                            _loading = false;

                            if (isLogedin.success) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text(
                                    isLogedin.message,
                                    textAlign: TextAlign.center,
                                    style: const TextStyle(
                                      color: Colors.black,
                                    ),
                                  ),
                                  backgroundColor: Colors.green,
                                  elevation: 14,
                                  behavior: SnackBarBehavior.floating,
                                ),
                              );
                              Navigator.of(context).pushReplacement(
                                PageTransition(
                                  type: PageTransitionType.scale,
                                  alignment: Alignment.bottomCenter,
                                  child: FeedScreen(),
                                ),
                              );
                            }
                            if (isLogedin.isError) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text(
                                    isLogedin.message,
                                    textAlign: TextAlign.center,
                                    style: const TextStyle(
                                      color: Colors.black,
                                    ),
                                  ),
                                  backgroundColor: Colors.red,
                                  elevation: 14,
                                  behavior: SnackBarBehavior.floating,
                                ),
                              );
                            }
                          }
                        },
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20 * fem),
                        ),
                        child: Container(
                          width: 500 * fem,
                          height: 58 * fem,
                          decoration: BoxDecoration(
                            color: const Color(0xff643600),
                            borderRadius: BorderRadius.circular(16 * fem),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                _loading ? "Logging...." : 'Login',
                                style: TextStyle(
                                  fontFamily: 'Poppins',
                                  fontSize: 18 * ffem,
                                  fontWeight: FontWeight.w700,
                                  height: 1.5 * ffem,
                                  color: const Color(0xffffffff),
                                ),
                              ),
                              SizedBox(width: 10 * fem),
                              Icon(
                                Icons.login,
                                size: 20.98 * fem,
                              ),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(height: 40 * fem),
                      Text(
                        'Don’t have an account?',
                        style: TextStyle(
                          fontFamily: 'Poppins',
                          fontSize: 12 * ffem,
                          fontWeight: FontWeight.w500,
                          height: 1.5 * ffem,
                          color: const Color(0xffcccdca),
                        ),
                      ),
                      TextButton(
                        onPressed: () {
                          Navigator.of(context).pushReplacement(
                            PageTransition(
                              type: PageTransitionType.scale,
                              alignment: Alignment.bottomCenter,
                              child: RegisterScreen(),
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
                            color: const Color(0xff643600),
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
      ),
    );
  }
}

class TickableContainer extends StatefulWidget {
  @override
  _TickableContainerState createState() => _TickableContainerState();
}

class _TickableContainerState extends State<TickableContainer> {
  bool isTicked = false;

  @override
  Widget build(BuildContext context) {
    double fem = 10.0;

    return GestureDetector(
      onTap: () {
        setState(() {
          isTicked = !isTicked;
        });
      },
      child: Container(
        width: 2 * fem,
        height: 2 * fem,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(2 * fem),
          border: Border.all(
            color: const Color.fromARGB(255, 94, 80, 80),
          ),
          color: isTicked ? Colors.brown : Colors.transparent,
        ),
      ),
    );
  }
}
