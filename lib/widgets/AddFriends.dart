import 'package:flutter/material.dart';

class AddFriend extends StatefulWidget {
  const AddFriend({Key? key}) : super(key: key);

  @override
  _AddFriendState createState() => _AddFriendState();
}

class _AddFriendState extends State<AddFriend> {
  bool _isLoading = false;
  bool _isLoggedIn = false;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(20),
      child: Container(
        width: 170,
        height: 35,
        child: ElevatedButton(
          style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all<Color>(
              _isLoggedIn ? Colors.green : Color.fromARGB(255, 167, 135, 135),
            ),
            shape: MaterialStateProperty.all<RoundedRectangleBorder>(
              RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
            ),
          ),
          onPressed: () async {
            if (_isLoggedIn) {
              // Placeholder for your logout logic
              // await logout();

              // Simulating a delay
              await Future.delayed(Duration(seconds: 2));

              setState(() {
                _isLoggedIn = false;
              });

              // Placeholder for navigating to the next screen or performing other actions
            } else {
              setState(() {
                _isLoading = true;
              });

              // Placeholder for your login logic
              // await login();

              // Simulating a delay
              await Future.delayed(Duration(seconds: 2));

              setState(() {
                _isLoading = false;
                _isLoggedIn = true;
              });

              // Placeholder for navigating to the next screen or performing other actions
            }
          },
          child: Container(
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Center(
                child: Text(
                  _isLoading
                      ? 'Logging...'
                      : (_isLoggedIn ? 'Request Sent' : 'Add Friend'),
                  style: TextStyle(
                    fontFamily: 'Poppins',
                    fontSize: 18,
                    fontWeight: FontWeight.w700,
                    height: 1.5,
                    color: const Color(0xffffffff),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
