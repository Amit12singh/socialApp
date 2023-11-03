import 'package:flutter/material.dart';

class SeeMoreText extends StatefulWidget {
  final String text;
  final int maxLines;

  SeeMoreText({required this.text, this.maxLines = 3});

  @override
  _SeeMoreTextState createState() => _SeeMoreTextState();
}

class _SeeMoreTextState extends State<SeeMoreText> {
  bool showFullText = false;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          widget.text,
          maxLines: showFullText ? null : widget.maxLines,
          overflow: showFullText ? null : TextOverflow.ellipsis,
        ),
        if (widget.text.split('\n').length > widget.maxLines)
          GestureDetector(
            onTap: () {
              setState(() {
                showFullText = !showFullText;
              });
            },
            child: Text(
              showFullText ? 'See Less' : 'See More',
              style: TextStyle(
                color: Colors.blue,
              ),
            ),
          ),
      ],
    );
  }
}
