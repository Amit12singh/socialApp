import 'package:flutter/material.dart';

class ProcessingDialog extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 0),
        child: Container(
          width: 10,
          height: 80,
          child: const Column(
            // mainAxisSize: MainAxisSize.min,
            children: [
              CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(
                    Color.fromARGB(255, 167, 135, 135)),
              ),
              SizedBox(height: 16.0),
              Text(
                "Loading...",
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                    color: Colors.black54),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

void showProcessingDialog(BuildContext context) {
  showDialog(
    context: context,
    barrierDismissible: false, // Dialog cannot be dismissed by tapping outside
    builder: (context) => SizedBox(width: 100, child: ProcessingDialog()),
  );
}


// void closeDialog(BuildContext context) {
//   Navigator.pop(context);
// }
