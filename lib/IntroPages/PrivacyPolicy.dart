import 'package:flutter/material.dart';

class PrivacyPolicyScreen extends StatelessWidget {
  const PrivacyPolicyScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 242, 239, 239),
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text(
          'Privacy Policy',
          style: TextStyle(
            color: Color(0xff643600),
          ),
        ),
        centerTitle: true,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios_new),
          color: Color(0xff643600),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ),
      body: Padding(
        padding: EdgeInsets.all(20.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                'Privacy Policy for PPS ONA',
                style: TextStyle(
                  fontSize: 16.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 10.0),
              Text(
                'This Privacy Policy was last updated on 11/15/2023.',
                style: TextStyle(
                  fontSize: 14.0,
                  color: Colors.grey,
                ),
              ),
              SizedBox(height: 10.0),
              Text(
                '1.   Introduction',
                style: TextStyle(
                  fontSize: 16.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 10.0),
              Text(
                'Welcome to [Your App Name] ("we," "us," "our"). This Privacy Policy explains how we collect, use, disclose, and safeguard your information when you use our mobile application (the "App").',
                style: TextStyle(
                  fontSize: 14.0,
                  color: Colors.grey,
                ),
              ),
              SizedBox(height: 10.0),
              Text(
                '2.   Information We Collect',
                style: TextStyle(
                  fontSize: 16.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 10.0),
              Text(
                '-Personal Information',
                style: TextStyle(
                  fontSize: 16.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 10.0),
              Text(
                'We may collect personal information, such as your name, email address, and other identifiable information that you voluntarily provide.',
                style: TextStyle(
                  fontSize: 14.0,
                  color: Colors.grey,
                ),
              ),
              SizedBox(height: 10.0),
              Text(
                '-Non Personal Information',
                style: TextStyle(
                  fontSize: 16.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 10.0),
              Text(
                'We may collect non-personal information, such as device information, usage statistics, and other analytics data.',
                style: TextStyle(
                  fontSize: 14.0,
                  color: Colors.grey,
                ),
              ),
              SizedBox(height: 10.0),
              Text(
                '3.   How We Use Your Information',
                style: TextStyle(
                  fontSize: 16.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 10.0),
              Text(
                "We use the information we collect to provide, maintain, and improve our App's features and functionality.\nYour personal information may be used for communication purposes, such as responding to your inquiries and providing customer support.",
                style: TextStyle(
                  fontSize: 14.0,
                  color: Colors.grey,
                ),
              ),
              SizedBox(height: 10.0),
              Text(
                '4.  Cookies and Similar Technologies ',
                style: TextStyle(
                  fontSize: 16.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 10.0),
              Text(
                'Our App may use cookies and similar tracking technologies to enhance your user experience.',
                style: TextStyle(
                  fontSize: 14.0,
                  color: Colors.grey,
                ),
              ),
              SizedBox(height: 10.0),
              Text(
                '5.   Security',
                style: TextStyle(
                  fontSize: 16.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 10.0),
              Text(
                'We take reasonable measures to protect the information collected from unauthorized access, disclosure, alteration, or destruction.',
                style: TextStyle(
                  fontSize: 14.0,
                  color: Colors.grey,
                ),
              ),
              SizedBox(height: 10.0),
              Text(
                '6.  Children\'s Privacy ',
                style: TextStyle(
                  fontSize: 16.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 10.0),
              Text(
                'Our App is not directed to individuals under the age of 13. We do not knowingly collect personal information from children. If you are a parent or guardian and become aware that your child has provided us with personal information, please contact us.',
                style: TextStyle(
                  fontSize: 14.0,
                  color: Colors.grey,
                ),
              ),
              SizedBox(height: 10.0),
              Text(
                '7.   Changes to This Privacy Policy',
                style: TextStyle(
                  fontSize: 16.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 10.0),
              Text(
                'We reserve the right to update our Privacy Policy at any time. Any changes will be effective when posted on this page.',
                style: TextStyle(
                  fontSize: 14.0,
                  color: Colors.grey,
                ),
              ),
              SizedBox(height: 10.0),
              Text(
                '7.   Contact Us',
                style: TextStyle(
                  fontSize: 16.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 10.0),
              Text(
                'If you have any questions or concerns about our Privacy Policy, please contact us at [your contact email].',
                style: TextStyle(
                  fontSize: 14.0,
                  color: Colors.grey,
                ),
              ),
              SizedBox(height: 10.0),
              Text(
                'By using our App, you agree to the collection and use of information in accordance with this Privacy Policy.',
                style: TextStyle(
                  fontSize: 14.0,
                  color: Colors.grey,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
