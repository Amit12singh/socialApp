import 'package:flutter/material.dart';
import 'package:myapp/models/response_model.dart';
import 'package:myapp/page-1/login.dart';
import 'package:myapp/services/user_service.dart';

class RegisterScreen extends StatefulWidget {
  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController fullNameController = TextEditingController();
  OutlineInputBorder errorBorder = OutlineInputBorder(
    borderSide: BorderSide(color: Colors.red),
  );

  final GraphQLService _graphQLService = GraphQLService();

  BoolResponseModel? _response;
  bool isLoading = false;
  bool _isPasswordVisible = false;

  void _create() async {
    setState(() {
      isLoading = true;
      _response = null;
    });
    BoolResponseModel response = await _graphQLService.registerUser(
      email: emailController.text,
      password: passwordController.text,
      fullName: fullNameController.text,
    );
    if (response.success) {
      setState(() {
        _response = response;
        isLoading = false;
      });

      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (context) => LoginScreen(),
        ),
      );
    }
  }

  bool _isValidEmail(String email) {
    final RegExp emailRegExp =
        RegExp(r'^[\w-]+(\.[\w-]+)*@([\w-]+\.)+[a-zA-Z]{2,7}$');
    return emailRegExp.hasMatch(email);
  }

  String _email = "";
  String _password = "";

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
          color: const Color(0xff643600),
        ),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(height: 70 * fem),
              Text(
                'Register Account',
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
                  horizontal: 12 * fem,
                  vertical: 40 * fem,
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
                      Padding(
                        padding: const EdgeInsets.all(0.5),
                        child: Text(
                          'Welcome',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontFamily: 'Poppins',
                            fontSize: 30 * ffem,
                            fontWeight: FontWeight.w700,
                            height: 1.5 * ffem,
                            color: const Color(0xff000000),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(3.0),
                        child: Text(
                          'Register Account to keep connected & get updates from us.',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontFamily: 'Poppins',
                            fontSize: 15 * ffem,
                            height: 1.5 * ffem,
                            color: const Color(0xff000000),
                          ),
                        ),
                      ),
                      SizedBox(height: 15 * fem),
                      Container(
                        margin: EdgeInsets.only(bottom: 8.33 * fem),
                        padding: EdgeInsets.fromLTRB(
                          12.5 * fem,
                          6.5 * fem,
                          6.5 * fem,
                          12.5 * fem,
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
                                Icons.person,
                                size: 20 * fem,
                              ),
                              SizedBox(width: 10.5 * fem),
                              Expanded(
                                child: TextFormField(
                                  controller: fullNameController,
                                  decoration: InputDecoration(
                                    hintText: 'Enter your Full name',
                                    hintStyle: TextStyle(
                                      fontFamily: 'Poppins',
                                      fontSize: 15 * ffem,
                                      fontWeight: FontWeight.w500,
                                      height: 1.5 * ffem,
                                      color: const Color(0xffdadbd8),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(height: 15 * fem),
                      Container(
                        margin: EdgeInsets.only(bottom: 8.33 * fem),
                        padding: EdgeInsets.fromLTRB(
                          10.5 * fem,
                          6.5 * fem,
                          6.5 * fem,
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
                                size: 20 * fem,
                              ),
                              SizedBox(width: 17.5 * fem),
                              Expanded(
                                child: TextFormField(
                                  controller: emailController,
                                  decoration: InputDecoration(
                                    hintText: 'Enter your email address',
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
                      SizedBox(height: 15 * fem),
                      Container(
                        margin: EdgeInsets.only(bottom: 8.33 * fem),
                        padding: EdgeInsets.fromLTRB(
                          10.5 * fem,
                          6.5 * fem,
                          6.5 * fem,
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
                                Icons.lock,
                                size: 20 * fem,
                              ),
                              SizedBox(width: 15 * fem),
                              Expanded(
                                child: TextFormField(
                                  controller: passwordController,
                                  decoration: InputDecoration(
                                    hintText: 'Enter password',
                                    hintStyle: TextStyle(
                                      fontFamily: 'Poppins',
                                      fontSize: 15 * ffem,
                                      fontWeight: FontWeight.w500,
                                      height: 1.5 * ffem,
                                      color: const Color(0xffdadbd8),
                                    ),
                                    errorBorder: errorBorder,
                                    focusedErrorBorder: errorBorder,
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
                                  size: 22 * fem,
                                  color: _isPasswordVisible
                                      ? Colors.blue
                                      : Colors.grey,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(height: 15 * fem),
                      Container(
                        margin: EdgeInsets.only(bottom: 8.33 * fem),
                        padding: EdgeInsets.fromLTRB(
                          10.5 * fem,
                          6.5 * fem,
                          6.5 * fem,
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
                                Icons.lock,
                                size: 20 * fem,
                              ),
                              SizedBox(width: 15 * fem),
                              Expanded(
                                child: TextFormField(
                                  controller: confirmPasswordController,
                                  decoration: InputDecoration(
                                    hintText: 'Enter Confirm password',
                                    hintStyle: TextStyle(
                                      fontFamily: 'Poppins',
                                      fontSize: 15 * ffem,
                                      fontWeight: FontWeight.w500,
                                      height: 1.5 * ffem,
                                      color: const Color(0xffdadbd8),
                                    ),
                                    errorBorder: errorBorder,
                                    focusedErrorBorder: errorBorder,
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
                                  size: 22 * fem,
                                  color: _isPasswordVisible
                                      ? Colors.blue
                                      : Colors.grey,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(height: 15 * fem),
                      TextButton(
                        onPressed: () async {
                          String password = passwordController.text;
                          String confirmPassword =
                              confirmPasswordController.text;

                          if (password != confirmPassword) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text(
                                  'Passwords do not match, Please enter correct Password',
                                  textAlign: TextAlign.center,
                                ),
                              ),
                            );
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text(
                                  'Register Success.',
                                  textAlign: TextAlign.center,
                                ),
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
                            color: const Color(0xff643600),
                            borderRadius: BorderRadius.circular(16 * fem),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                'Register Account',
                                style: TextStyle(
                                  fontFamily: 'Poppins',
                                  fontSize: 18 * ffem,
                                  fontWeight: FontWeight.w700,
                                  height: 1.5 * ffem,
                                  color: const Color(0xffffffff),
                                ),
                              ),
                              SizedBox(width: 5 * fem),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Icon(
                                  Icons.login,
                                  size: 17.98 * fem,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(height: 15 * fem),
                      Text(
                        'Already have an account?',
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
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) => LoginScreen(),
                            ),
                          );
                        },
                        style: TextButton.styleFrom(
                          padding: EdgeInsets.zero,
                        ),
                        child: Text(
                          'Log in',
                          style: TextStyle(
                            fontFamily: 'Poppins',
                            fontSize: 12 * ffem,
                            fontWeight: FontWeight.w500,
                            height: 1.5 * ffem,
                            color: const Color(0xff643600),
                          ),
                        ),
                      ),
                      SizedBox(height: 0.5 * fem),
                      Center(
                        child: Padding(
                          padding: EdgeInsets.symmetric(vertical: 0.5 * fem),
                          child: Text(
                            'By creating an account, you agree to our Terms & Conditions and agree to Privacy Policy.',
                            style: TextStyle(
                              fontFamily: 'Poppins',
                              fontSize: 12 * ffem,
                              fontWeight: FontWeight.w500,
                              height: 1.5 * ffem,
                              color: const Color(0xff643600),
                            ),
                            textAlign: TextAlign.center,
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
