import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:otp_text_field/otp_field.dart';
import 'package:ppsona/models/response_model.dart';
import 'package:ppsona/services/user_service.dart';
import 'package:ppsona/widgets/emailInputPage.dart';

class ResetPasswordPage extends StatefulWidget {
  @override
  _ResetPasswordPageState createState() => _ResetPasswordPageState();
}

class _ResetPasswordPageState extends State<ResetPasswordPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();
  String token = '';
  GraphQLService userService = GraphQLService();

  bool _isPasswordVisible1 = false;
  bool _isPasswordVisible2 = false;

  bool isButtonEnabled = false;
  int countdown = 30;

  late Timer countdownTimer;

  @override
  void initState() {
    super.initState();
    startCountdown();
  }

  void resetPassword() async {
    final BoolResponseModel res = await userService.resetPass(
        password: passwordController.text, otp: token);

    final snackBar = SnackBar(
      content: Text(res.message),
      backgroundColor: res.success ? Colors.green : Colors.red,
    );

// Find the ScaffoldMessenger in the widget tree
// and use it to show a SnackBar.
    ScaffoldMessenger.of(context).showSnackBar(snackBar);

    if (res.success) {
      Navigator.of(context).pop();
    }
  }

  void startCountdown() {
    countdownTimer = Timer.periodic(Duration(seconds: 1), (timer) {
      setState(() {
        countdown--;
        if (countdown == 0) {
          isButtonEnabled = true;
          timer.cancel(); // Stop the countdown timer
        }
      });
    });
  }

  @override
  void dispose() {
    countdownTimer.cancel(); // Dispose of the timer to prevent memory leaks
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double baseWidth = 390;
    double fem = MediaQuery.of(context).size.width / baseWidth;
    double ffem = fem * 0.97;
    return Scaffold(
      appBar: AppBar(
        systemOverlayStyle: const SystemUiOverlayStyle(
          statusBarColor: Colors.white,
          statusBarIconBrightness: Brightness.dark,
          statusBarBrightness: Brightness.light,
        ),
        backgroundColor: Colors.white,
        elevation: 1,
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back_ios,
            color: const Color(0xff643600),
          ),
          onPressed: () {
            Navigator.of(context)
                .pop(); // Navigate back when the button is pressed
          },
        ),
        centerTitle: true,
        title: const Text('Reset Password',
            style: TextStyle(color: Color(0xff643600))),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              const Text('Enter security code', style: TextStyle(fontSize: 28)),
              const SizedBox(
                height: 20,
              ),
              const Text(
                  'Please check your email for a message with your code. Your code is 6 numbers long.',
                  style: TextStyle(fontSize: 18)),
              const SizedBox(
                height: 30,
              ),
              Form(
                key: _formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text("Enter Token", style: TextStyle(fontSize: 20)),
                    Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: 15.5 * fem,
                      ),
                      child: OTPTextField(
                        length: 6,
                        width: MediaQuery.of(context).size.width,
                        style: TextStyle(fontSize: 17),
                        textFieldAlignment: MainAxisAlignment.spaceAround,
                        onCompleted: (pin) {
                          setState(() {
                            token = pin;
                          });
                        },
                      ),
                    ),
                    const SizedBox(height: 30),
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
                                  suffixIcon: GestureDetector(
                                    child: Icon(
                                      _isPasswordVisible1
                                          ? Icons.visibility
                                          : Icons.visibility_off,
                                    ),
                                    onTap: () {
                                      setState(() {
                                        _isPasswordVisible1 =
                                            !_isPasswordVisible1;
                                      });
                                    },
                                  ),
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
                                obscureText: !_isPasswordVisible1,
                              ),
                            ),
                            SizedBox(width: 0.5 * fem),
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
                        child: Row(children: [
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
                                suffixIcon: GestureDetector(
                                  child: Icon(
                                    _isPasswordVisible2
                                        ? Icons.visibility
                                        : Icons.visibility_off,
                                  ),
                                  onTap: () {
                                    setState(() {
                                      _isPasswordVisible2 =
                                          !_isPasswordVisible2;
                                    });
                                  },
                                ),
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
                              obscureText: !_isPasswordVisible2,
                            ),
                          ),
                        ]),
                      ),
                    ),
                    const SizedBox(height: 16),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text('Try to get code after $countdown seconds'),
                            TextButton(
                              onPressed: () {
                                isButtonEnabled
                                    ? Navigator.of(context).pushReplacement(
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                emailInputPage(
                                                  title: "Forgot Password",
                                                  onTap: userService
                                                      .forgotPasswordFunc,
                                                )))
                                    : null;
                              },
                              child: Text(
                                'Didn\'t get code? ',
                                style: TextStyle(
                                  color: isButtonEnabled
                                      ? Colors.blue
                                      : Colors.grey,
                                ),
                              ),
                            ),
                          ],
                        ),
                        ElevatedButton(
                          style: ButtonStyle(
                              backgroundColor:
                                  MaterialStateProperty.all<Color?>(
                                      Color(0xff643600))),
                          onPressed: () {
                            String newPassword = passwordController.text;
                            String confirmPassword =
                                confirmPasswordController.text;
                            if (_formKey.currentState!.validate()) {
                              if (newPassword.isNotEmpty &&
                                  newPassword == confirmPassword) {
                                resetPassword();
                              } else {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: const Text(
                                        'Passwords need to be the same'),
                                    backgroundColor: Colors.red,
                                    behavior: SnackBarBehavior.floating,
                                    action: SnackBarAction(
                                      label: 'Close',
                                      textColor: Colors.white,
                                      onPressed: () {
                                        ScaffoldMessenger.of(context)
                                            .hideCurrentSnackBar();
                                      },
                                    ),
                                  ),
                                );
                              }
                            }
                          },
                          child: const Text('Continue'),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
