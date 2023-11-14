import 'package:flutter/material.dart';
import 'package:myapp/IntroPages/Intro_Page_1.dart';
import 'package:myapp/IntroPages/Intro_Page_2.dart';
import 'package:myapp/IntroPages/Intro_Page_3.dart';
import 'package:myapp/page-1/login.dart';
import 'package:page_transition/page_transition.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class onboardingScreen extends StatefulWidget {
  const onboardingScreen({super.key});

  @override
  State<onboardingScreen> createState() => _onboardingScreenState();
}

class _onboardingScreenState extends State<onboardingScreen> {
  PageController _controller = PageController();
  bool _loading = false;
  bool onLastPage = false;
  void navigateToLoginScreen() async {
    setState(() {
      _loading = true;
    });

    await Future.delayed(Duration(seconds: 2));

    Navigator.of(context).pushReplacement(
      MaterialPageRoute(builder: (context) {
        setState(() {
          _loading = false;
        });
        return LoginScreen();
      }),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          PageView(
            controller: _controller,
            onPageChanged: (index) {
              setState(() {
                onLastPage = (index == 2);
              });
            },
            children: const [
              IntroPage1(),
              IntroPage2(),
              IntroPage3(),
            ],
          ),
          Container(
            alignment: const Alignment(0, 0.9),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                GestureDetector(
                    onTap: () {
                      _controller.jumpToPage(2);
                    },
                    child: const Text('skip')),
                SmoothPageIndicator(
                  controller: _controller,
                  count: 3,
                  effect: const ExpandingDotsEffect(
                    activeDotColor: Colors.blue,
                    dotColor: Colors.grey,
                    dotHeight: 12,
                    dotWidth: 12,
                    spacing: 8,
                  ),
                ),
                onLastPage
                    ? GestureDetector(
                        onTap: () {
                          Navigator.of(context).pushReplacement(
                            PageTransition(
                              type: PageTransitionType.scale,
                              alignment: Alignment.bottomCenter,
                              child: LoginScreen(),
                            ),
                          );
                        },
                        child: const Text('done'),
                      )
                    : GestureDetector(
                        onTap: () {
                          _controller.nextPage(
                            duration: const Duration(milliseconds: 500),
                            curve: Curves.easeIn,
                          );
                        },
                        child: const Text('next'),
                      ),
              ],
            ),
          ),
          if (_loading)
            Center(
              child: CircularProgressIndicator(),
            ),
        ],
      ),
    );
  }
}
