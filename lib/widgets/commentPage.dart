import 'package:flutter/material.dart';
import 'package:myapp/models/comment_model.dart';
import 'package:myapp/models/user_model.dart';
import 'package:myapp/widgets/comment_card.dart';

class CommentScreen extends StatefulWidget {
  final UserModel loggedInUser;
  final List<CommentModel>? comments;
  CommentScreen({Key? key, required this.loggedInUser, required this.comments})
      : super(key: key);

  @override
  State<CommentScreen> createState() => _CommentScreenState();
}

class _CommentScreenState extends State<CommentScreen> {
  final TextEditingController commentEditingController =
      TextEditingController();

  void postComment(String uid, String name, String profilePic) async {
    // try {
    //   String res = await FireStoreMethods().postComment(
    //     widget.snap['postId'],
    //     commentEditingController.text,
    //     uid,
    //     name,
    //     profilePic,
    //   );

    //   if (res != 'success') {
    //     showSnackBar(
    //       res,
    //       context,
    //     );
    //   }
    //   setState(() {
    //     commentEditingController.text = "";
    //   });
    // } catch (err) {
    //   showSnackBar(
    //     err.toString(),
    //     context,
    //   );
    // }
  }

  dynamic() => print(widget.loggedInUser);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Comments'),
          centerTitle: false,
        ),
        body: Container(
          child: widget.comments!.isEmpty
              ? Center(
                  child: Container(
                    child: Text(
                      'No comments yet.',
                      style:
                          TextStyle(fontWeight: FontWeight.w500, fontSize: 20),
                    ),
                  ),
                )
              : ListView.builder(
                  itemCount: widget.comments?.length,
                  itemBuilder: (ctx, index) {
                    return CommentCard(
                      comment: widget.comments![index],
                    );
                  }),
        ),
        bottomNavigationBar: SafeArea(
            child: Container(
                height: kToolbarHeight,
                margin: EdgeInsets.only(
                    bottom: MediaQuery.of(context).viewInsets.bottom),
                padding: const EdgeInsets.only(left: 16, right: 8),
                child: Row(
                  children: [
                    CircleAvatar(
                      backgroundImage: NetworkImage(
                          widget.loggedInUser.profilePicture?.path ?? ''),
                      radius: 20,
                      backgroundColor: Colors.transparent,
                    ),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.only(left: 16, right: 8),
                        child: TextField(
                          controller: commentEditingController,
                          decoration: InputDecoration(
                            hintText:
                                'Comment as ${widget.loggedInUser.fullName}',
                            border: InputBorder.none,
                          ),
                          onSubmitted: (e) {
                            //   postComment(
                            //       widget.usersnap['uid'],
                            //       widget.usersnap['name'],
                            //       widget.usersnap['photoUrl']);
                            //
                          },
                        ),
                      ),
                    )
                  ],
                ))));
  }
}

showSnackBar(String content, BuildContext context) {
  ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(content)));
}
