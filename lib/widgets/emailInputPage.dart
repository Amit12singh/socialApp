import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:myapp/widgets/resetPasswordPage.dart';

class emailInputPage extends StatefulWidget {
  final String title;
  final Function(String) onTap;
  const emailInputPage({super.key, required this.title, required this.onTap});

  @override
  _EmailInputPageState createState() => _EmailInputPageState();
}

class _EmailInputPageState extends State<emailInputPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final TextEditingController _emailController = TextEditingController();

  bool isEmailValid(String email) {
    String emailPattern = r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$';
    RegExp regex = RegExp(emailPattern);
    return regex.hasMatch(email);
  }

  @override
  Widget build(BuildContext context) {
    double baseWidth = 390;
    double fem = MediaQuery.of(context).size.width / baseWidth;
    double ffem = fem * 0.97;
    return Scaffold(
      appBar: AppBar(
        systemOverlayStyle: const SystemUiOverlayStyle(
          statusBarColor: Color.fromARGB(255, 167, 135, 135),
          statusBarIconBrightness: Brightness.dark,
          statusBarBrightness: Brightness.light,
        ),
        elevation: 1,
        backgroundColor: Colors.white,
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back_ios,
            color: const Color(0xff643600),
          ),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        centerTitle: true,
        title: Text(
          widget.title,
          style: const TextStyle(color: Color(0xff643600)),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                "Verify your email",
                style: TextStyle(fontSize: 20),
              ),
              const SizedBox(height: 20),
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
                        Icons.email_rounded,
                        size: 20 * fem,
                      ),
                      SizedBox(width: 17.5 * fem),
                      Expanded(
                        child: TextFormField(
                          enableSuggestions: true,
                          controller: _emailController,
                          keyboardType: TextInputType.emailAddress,
                          decoration: InputDecoration(
                            label: const Text('Email'),
                            hintText: 'Enter your email address',
                            focusedBorder: const UnderlineInputBorder(
                                borderSide: BorderSide(
                                    color: Color(0xff643600), width: 1)),
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
                              return 'Enter your email.';
                            } else if (!isEmailValid(value)) {
                              return 'Invalid email address.';
                            }
                            return null;
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 16),
              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: const Text(
                    'Login with password',
                    style: TextStyle(color: Color.fromARGB(255, 167, 135, 135)),
                  ),
                ),
                ElevatedButton(
                  style: ButtonStyle(
                    backgroundColor:
                        MaterialStateProperty.all<Color>(Color(0xff643600)),
                  ),
                  onPressed: () async {
                    if (_formKey.currentState!.validate()) {
                      String enteredEmail = _emailController.text;
                      widget.onTap(enteredEmail);
                      Navigator.of(context).pushReplacement(MaterialPageRoute(
                          builder: (context) => ResetPasswordPage()));
                    }
                  },
                  child: const Text('Continue'),
                ),
              ])
            ],
          ),
        ),
      ),
    );
  }
}
