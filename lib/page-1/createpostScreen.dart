import 'package:flutter/material.dart';

class CreatePostScreen extends StatefulWidget {
  @override
  _CreatePostScreen createState() => _CreatePostScreen();
}

class _CreatePostScreen extends State<CreatePostScreen> {
  final TextEditingController _textController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: 812,
        color: Colors.white,
        child: Stack(
          children: [
            Positioned(
              left: 15.625,
              top: 23.87890625,
              child: CreatePostWidget(),
            ),
            Positioned(
              left: 0,
              top: 72.2421875,
              child: RectangleWidget(height: 0.5),
            ),
            Positioned(
              left: 0,
              top: 912.978515625,
              child: RectangleWidget(height: 4),
            ),
            Positioned(
              left: 0,
              top: 906.478515625,
              child: RectangleWidget(height: 1),
            ),
            Positioned(
              left: 0,
              top: 72.7421875,
              child: Container(
                padding: EdgeInsets.fromLTRB(24.38, 18.36, 29.94, 367.63),
                width: 375,
                height: 833.74,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ProfileWidget(),
                    TextFormField(
                      controller: _textController,
                      decoration: InputDecoration(
                        hintText: "What's on your mind?",
                        hintStyle: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w400,
                          color: Color(0xffbebebe),
                        ),
                      ),
                    ),
                    ActionsWidget(),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _textController.dispose();
    super.dispose();
  }
}

class CreatePostWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 341.38,
      height: 26,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          CreatePostButton(),
          Text(
            'Create post',
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w500,
              color: Color(0xff000000),
            ),
          ),
        ],
      ),
    );
  }
}

class CreatePostButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.fromLTRB(0, 1.5, 179.63, 1.5),
      height: double.infinity,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          IconWithText(
            iconUrl: '[auto-group-76wv.png]', // Replace with your image URL
            text: '9:41',
          ),
        ],
      ),
    );
  }
}

class IconWithText extends StatelessWidget {
  final String iconUrl;
  final String text;

  IconWithText({required this.iconUrl, required this.text});

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: EdgeInsets.fromLTRB(0, 0, 9.75, 0),
        width: 27,
        height: double.infinity,
        child: Stack(children: [
          Positioned(
            left: 0,
            top: 0,
            child: Align(
              child: SizedBox(
                width: 27,
                height: 23,
                child: Text(
                  text,
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w500,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ),
          Positioned(
            left: 8.75,
            top: 5.5,
            child: Align(
              child: SizedBox(
                width: 14,
                height: 12,
                child: Image.network(
                  iconUrl,
                  width: 14,
                  height: 12,
                ),
              ),
            ),
          )
        ]));
  }
}

class RectangleWidget extends StatelessWidget {
  final double height;

  RectangleWidget({required this.height});

  @override
  Widget build(BuildContext context) {
    return Align(
      child: SizedBox(
        width: 375,
        height: height,
        child: Container(
          decoration: BoxDecoration(
            color: Color(0xffd9d9d9),
          ),
        ),
      ),
    );
  }
}

class ProfileWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.fromLTRB(0, 0, 170.69, 24.86),
      width: double.infinity,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          CircleAvatarWidget(
              imageUrl:
                  'logo-3-removebg-preview-1.png'), // Replace with your image URL
          Text(
            'Old Nabhaites',
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: Color(0xff000000),
            ),
          ),
        ],
      ),
    );
  }
}

class ActionsWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        ActionButtonWidget(text: 'Photo', iconUrl: 'auto-group-dbpd.png'),
        ActionButtonWidget(text: 'Video', iconUrl: 'auto-group-76wv.png'),
      ],
    );
  }
}

class ActionButtonWidget extends StatelessWidget {
  final String text;
  final String iconUrl;

  ActionButtonWidget({required this.text, required this.iconUrl});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.fromLTRB(0, 0, 15.13, 0),
      padding: EdgeInsets.fromLTRB(53, 15, 53, 14.5),
      width: 150,
      height: double.infinity,
      decoration: BoxDecoration(
        color: Color(0xffefe3d7),
        borderRadius: BorderRadius.circular(6),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          CircleAvatarWidget(imageUrl: iconUrl),
          Text(
            text,
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w400,
              color: Color(0xff000000),
            ),
          ),
        ],
      ),
    );
  }
}

class CircleAvatarWidget extends StatelessWidget {
  final String imageUrl;

  CircleAvatarWidget({required this.imageUrl});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.fromLTRB(0, 0, 0, 5.5),
      width: 44,
      height: 44,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(22),
        image: DecorationImage(
          fit: BoxFit.contain,
          image: NetworkImage(imageUrl),
        ),
      ),
    );
  }
}
