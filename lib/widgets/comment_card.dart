import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:myapp/models/article_model.dart';
import 'package:myapp/models/comment_model.dart';

class CommentCard extends StatelessWidget {
  final CommentModel comment;
  const CommentCard({Key? key, required this.comment}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              CircleAvatar(
                backgroundImage: NetworkImage(
                  comment.user?.profilePicture?.path ?? '',
                ),
                radius: 18,
              ),
              Expanded(
                child: Container(
                  padding: const EdgeInsets.all(15),
                  decoration: BoxDecoration(color: Colors.grey[200]),
                  margin:
                      const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
                  child: Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          comment.user?.fullName ?? '',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        Container(
                          margin: EdgeInsets.symmetric(
                              vertical: 10), // Text(DateFormat.yMMMd()
                          //     .format(comment.data()['datePublished'].toDate())),
                          child: Text(comment.comment),
                        )
                      ],
                    ),
                  ),
                ),
              )
            ],
          ),
          Container(
            margin: EdgeInsets.symmetric(horizontal: 60),
            child: Text('Like'),
          )
        ],
      ),
    );
  }
}
