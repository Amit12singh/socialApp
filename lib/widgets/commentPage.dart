import 'package:flutter/material.dart';
import 'package:myapp/models/article_model.dart';
import 'package:myapp/models/comment_model.dart';
import 'package:myapp/models/user_model.dart';
import 'package:myapp/services/article_service.dart';
import 'package:myapp/widgets/comment_card.dart';

class CommentScreen extends StatefulWidget {
  final UserModel loggedInUser;
  final ArticleModel? post;
  CommentScreen({Key? key, required this.loggedInUser, required this.post})
      : super(key: key);

  @override
  State<CommentScreen> createState() => _CommentScreenState();
}

class _CommentScreenState extends State<CommentScreen> {
  final TextEditingController commentEditingController =
      TextEditingController();
  late List<CommentModel> comments = [];

  final PostService postService = PostService();

  void postComment(String id, String comment) async {
    CommentModel newComment = CommentModel(
        id: UniqueKey().toString(),
        user: widget.loggedInUser,
        comment: comment,
        createdAt: DateTime.now());

    comments.insert(0, newComment);
    await postService.addComment(id, comment);
  }

  @override
  void initState() {
    super.initState();
    comments = widget.post?.comments ?? [] as List<CommentModel>;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Comments'),
        centerTitle: true,
        backgroundColor: Colors.white,
        foregroundColor: const Color.fromARGB(255, 167, 135, 135),
        leading: IconButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            icon: Icon(Icons.arrow_back_ios_new_outlined)),
      ),
      body: Container(
        child: comments.isEmpty
            ? const Center(
                child: Text(
                  'No comments yet.',
                  style: TextStyle(fontWeight: FontWeight.w500, fontSize: 20),
                ),
              )
            : ListView.builder(
                itemCount: comments.length,
                itemBuilder: (ctx, index) {
                  return CommentCard(
                    comment: comments[index],
                  );
                }),
      ),
      bottomNavigationBar: SafeArea(
        child: Container(
          height: kToolbarHeight,
          margin:
              EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
          padding: const EdgeInsets.only(left: 16, right: 8),
          child: Row(
            children: [
              widget.loggedInUser.profilePicture != null
                  ? CircleAvatar(
                      backgroundImage: NetworkImage(
                          widget.loggedInUser.profilePicture?.path ?? ''),
                      radius: 20,
                      backgroundColor: Colors.transparent,
                    )
                  : const CircleAvatar(
                      backgroundImage: AssetImage(
                          'assets/page-1/images/ellipse-1-bg-nRo.png'),
                      radius: 20,
                      backgroundColor: Colors.transparent,
                    ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(left: 16, right: 8),
                  child: TextField(
                    controller: commentEditingController,
                    decoration: InputDecoration(
                      hintText: 'Comment as ${widget.loggedInUser.fullName}',
                      border: InputBorder.none,
                    ),
                    onSubmitted: (e) {
                      postComment(widget.post?.id ?? '', e);
                      commentEditingController.text = '';
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

showSnackBar(String content, BuildContext context) {
  ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(content)));
}
