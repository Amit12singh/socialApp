import 'package:flutter/material.dart';
import 'package:myapp/models/comment_model.dart';
import 'package:timeago/timeago.dart' as timeago;


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
                  comment.user.profilePicture?.path ?? '',
                ),
                radius: 18,
              ),
              Expanded(
                child: Container(
                  padding: const EdgeInsets.all(15),
                  decoration: BoxDecoration(color: Colors.grey[200]),
                  margin:
                      const EdgeInsets.only(bottom: 0, left: 15, right: 15),
                  child: Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              comment.user.fullName,
                              style:
                                  const TextStyle(fontWeight: FontWeight.bold),
                            ),
                            Text(
                              timeago.format(
                                comment.createdAt, // Your DateTime object
                                locale:
                                    'en', // Use the same locale as set in step 3
                              ),
                            )
                          ],
                        ),
                        Container(
                          margin: const EdgeInsets.symmetric(vertical: 10), //
                              
                          child: Text(comment.comment),
                        ),
                       
                      ],
                    ),
                  ),
                ),
              )
            ],
          ),
          // Container(
          //   margin: EdgeInsets.symmetric(horizontal: 60),
          //   child: Text('Like'),
          // )
        ],
      ),
    );
  }
}
