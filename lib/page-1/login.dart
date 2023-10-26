import 'package:flutter/material.dart';
import 'package:myapp/page-1/feeds/homescreen.dart';
import 'package:myapp/register.dart';
import 'package:myapp/services/user_service.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final GraphQLService _graphQLService = GraphQLService();

  bool _loggedIn = false;
  bool _loading = false;

  // void _load() async {
  //   _loading = true;
  //   bool isLoggedIn =
  //       await _graphQLService.login(email: _email, password: _password);

  //   if (_loggedIn) {
  //     _loading = false;
  //   }
  //   setState(() => _loggedIn = isLoggedIn);
  // }

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
    double baseWidth = 400;
    double fem = MediaQuery.of(context).size.width / baseWidth;
    double ffem = fem * 0.97;

    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
          color: const Color(0xff643600),
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
                                Icons.inbox,
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
                                  obscureText:
                                      !_isPasswordVisible, // Toggle password visibility
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
                                      : Colors.grey, // Customize the color
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(height: 30 * fem),
                      Row(
                        children: [
                          TickableContainer(),
                          // Container(
                          //   width: 13 * fem,
                          //   height: 13 * fem,
                          //   decoration: BoxDecoration(
                          //     borderRadius: BorderRadius.circular(2 * fem),
                          //     border: Border.all(
                          //         color: Color.fromARGB(255, 94, 80, 80)),
                          //   ),
                          // ),
                          SizedBox(width: 15 * fem),
                          Text(
                            'Remember me',
                            style: TextStyle(
                              fontFamily: 'Poppins',
                              fontSize: 12 * ffem,
                              fontWeight: FontWeight.w500,
                              height: 1.5 * ffem,
                              color: Color.fromARGB(255, 83, 65, 76),
                            ),
                          ),
                          Spacer(),
                          TextButton(
                            onPressed: () {
                              Navigator.of(context).pushReplacement(
                                MaterialPageRoute(
                                  builder: (context) => RegisterScreen(),
                                ),
                              );
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
                                color: const Color(0xff643600),
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 30 * fem),
                      TextButton(
                        onPressed: () async {
                          if (_formKey.currentState!.validate()) {
                            _formKey.currentState!.save();

                            _loading = true;

                            final isLogedin = await _graphQLService.login(
                                email: _email, password: _password);
                            _loading = false;

                            if (isLogedin) {
                              Navigator.of(context).pushReplacement(
                                MaterialPageRoute(
                                  builder: (context) => const FeedScreen(),
                                ),
                              );
                            }
                          }
                        },
                        style: TextButton.styleFrom(
                          padding: EdgeInsets.zero,
                        ),
                        child: Container(
                          width: 332 * fem,
                          height: 58 * fem,
                          decoration: BoxDecoration(
                            color: const Color(0xff643600),
                            borderRadius: BorderRadius.circular(16 * fem),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment
                                .center, // Center both elements horizontally
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
                              SizedBox(
                                  width: 5 *
                                      fem), // Add some spacing between text and icon
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
                            color: const Color(0xff643600),
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

class TickableContainer extends StatefulWidget {
  @override
  _TickableContainerState createState() => _TickableContainerState();
}

class _TickableContainerState extends State<TickableContainer> {
  bool isTicked = false;

  @override
  Widget build(BuildContext context) {
    double fem = 10.0; // Replace with your actual value

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
            color: Color.fromARGB(255, 94, 80, 80),
          ),
          color: isTicked
              ? Colors.brown
              : Colors.transparent, // Add a color for the ticked state
        ),
      ),
    );
  }
}
