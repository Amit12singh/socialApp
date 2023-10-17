// ignore_for_file: unnecessary_string_interpolations

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:myapp/models/article_model.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:myapp/models/user_model.dart';
import 'package:myapp/services/article_service.dart';
import 'package:myapp/utilities/localstorage.dart';

class PostScreen extends StatefulWidget {
  final List posts; // Add this parameter

  const PostScreen({Key? key, required this.posts}) : super(key: key);

  @override
  _PostScreenState createState() => _PostScreenState();
}

class _PostScreenState extends State<PostScreen> {
  final _postService = PostService();
  bool _isLiked = false;
  final currentUser = HandleToken().getUser();

  @override
  @override
  void initState() {
    super.initState();
  }

  // final posts = widget.posts;

  Future<bool> isAlreadyLiked() async {
    final currentUser = await HandleToken().getUser();

    widget.posts.map((e) => {
          if (currentUser != null && e?.likes != null)
            {e?.likes?.any((like) => like.user?.id == currentUser.id) ?? false}
        });

    return false;
  }

  _likePost(String atricleId) async {
    final isLiked = await _postService.likePost(atricleId);

    setState(() {
      _isLiked = isLiked;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (widget.posts == null) {
      return const Center(
        child: CircularProgressIndicator(),
      );
    } else {
      return ListView.builder(
        itemCount: widget.posts?.length, // Number of widget.posts
        itemBuilder: (context, index) {
          return buildPostCard(widget.posts[index]);
        },
      );
    }
  }

  Widget buildPostCard(ArticleModel post) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 5.0),
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      color: Color.fromARGB(255, 255, 255, 255),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                _PostHeader(post: post),
                const SizedBox(
                  height: 4.0,
                ),
                Text(post.title),
                post?.media == null
                    ? const SizedBox.shrink()
                    : const SizedBox(height: 6),
              ],
            ),
          ),
          post.media != null && post.media!.isNotEmpty
              ? Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8),
                  child: Image(
                    image: NetworkImage(
                        Uri.parse(post.media?[0].path ?? '').toString()),
                  ),
                )
              : const SizedBox.shrink(),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            child: _PostStats(
              post: post,
              likePost: _likePost,
              isPostLiked: _isLiked,
            ), // Pass the post to _PostStats
          ),
        ],
      ),
    );
  }
}

class $ {}

class _PostHeader extends StatelessWidget {
  const _PostHeader({
    Key? key,
    required this.post,
  }) : super(key: key);

  final ArticleModel post;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        CircleAvatar(
          backgroundImage:
              NetworkImage(post?.owner?.profilePicture?.path ?? ''),
        ),
        SizedBox(width: 8),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                '${post.owner?.fullName ?? ''}',
                style: const TextStyle(fontWeight: FontWeight.w600),
              ),
              Row(
                children: [
                  Text(
                    '${post.createdAt}.',
                    style: TextStyle(
                      color: Colors.grey[600],
                      fontSize: 12.0,
                    ),
                  ),
                  Icon(
                    Icons.public,
                    color: Colors.grey[600],
                    size: 12.0,
                  )
                ],
              )
            ],
          ),
        ),
        IconButton(
          icon: const Icon(Icons.more_horiz),
          onPressed: () => print('more'),
        )
      ],
    );
  }
}

class _PostStats extends StatelessWidget {
  const _PostStats(
      {Key? key,
      required this.post,
      required this.likePost,
      required this.isPostLiked})
      : super(key: key);

  final ArticleModel post;
  final Function likePost;
  final bool isPostLiked;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Container(
              padding: const EdgeInsets.all(4.0),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
              ),
              child: const Icon(
                Icons.favorite_border_rounded,
                size: 10,
                color: Colors.white,
              ),
            ),
            const SizedBox(width: 4),
            Text(
              '${post.totalLikes}',
              style: TextStyle(
                color: Colors.grey[600],
              ),
            )
          ],
        ),
        const Divider(),
        Row(
          children: [
            _PostButton(
              icon: Icon(
                MdiIcons.heartOutline, // Use the appropriate icon for "Like"
                color: Colors.grey[600],
                size: 20,
              ),
              label: 'Like',
              onTap: () => {likePost(post.id)},
            ),
          ],
        ),
      ],
    );
  }
}

class _PostButton extends StatelessWidget {
  final Key? key;
  final Icon icon;
  final String label;
  final Function() onTap;

  _PostButton({
    this.key,
    required this.icon,
    required this.label,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Material(
        color: Colors.white,
        child: InkWell(
          onTap: onTap,
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            height: 25,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                icon,
                const SizedBox(
                  width: 4,
                ),
                Text(label),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
