import 'package:flutter/material.dart';

class About_us extends StatefulWidget {
  const About_us({super.key});

  @override
  State<About_us> createState() => _About_usState();
}

class _About_usState extends State<About_us> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 167, 135, 135),
        title: Text(
          'About Us',
          style: TextStyle(color: Colors.black),
        ),
        centerTitle: true,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios_new),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ),
      body: const Padding(
        padding: const EdgeInsets.all(20.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                'The idea for the Old Nabhaite Association app was born out of this very nostalgia and a profound sense of gratitude towards our alma mater. As we ventured into the world beyond school, we found ourselves longing for a way to stay connected with our fellow Old Nabhaite friends and to keep the spirit of PPS Nabha alive in our hearts. This longing, combined with the desire to give back to the institution that had played such a crucial role in shaping our lives, led us to conceptualize this app.\n\n'
                'We envisioned a digital platform that would serve as a bridge between the past and the present, allowing us to reconnect with old friends, share our life experiences, and relive the cherished moments from our school days. We wanted to create a space where the Old Nabhaite community could thrive, where we could preserve our shared history, and where future generations could benefit from the legacy of our alma mater.\n\n'
                'With the support and encouragement of the Old Nabhaite Association (ONA), we embarked on the journey of developing this app. Today, as we launch it on the special occasion of the ONA Conclave, we are filled with a profound sense of joy and accomplishment. This app is our way of expressing gratitude to PPS Nabha for the invaluable education, friendships, and memories it provided us.\n\n'
                'We invite all Old Nabhaite friends to join us in this endeavor, to continue celebrating our past, and to contribute to the vibrant community we are building together. Let\'s keep the Old Nabhaite spirit alive, and let\'s make this digital space a testament to the enduring bond we share as alumni of PPS Nabha.\n\n'
                'Thank you for being a part of this journey, and we look forward to connecting with all of you through the Old Nabhaite Association app.',
                style: TextStyle(
                  fontSize: 15,
                  // fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 15),
              Text(
                'Donated by\n'
                'Vivek mittal (s0666)\n'
                'Chirayu mittal (R00046)\n'
                'Bholesh mittal (R00045)\n'
                'Hunar mittal (R000125)\n'
                'Namish mittal (B00227)\n'
                'Kush mittal (s00407)',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
