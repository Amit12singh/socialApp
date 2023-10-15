import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:myapp/models/article_model.dart';
import 'package:myapp/utilities/localstorage.dart';
import 'package:user_profile_avatar/user_profile_avatar.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class PostScreen extends StatefulWidget {
  final List<ArticleModel> posts; // Add this parameter

  const PostScreen({Key? key, required this.posts}) : super(key: key);

  @override
  _PostScreenState createState() => _PostScreenState();
}

class _PostScreenState extends State<PostScreen> {
  // final posts = widget.posts;

  @override
  Widget build(BuildContext context) {
    {
      return ListView.builder(
        itemCount: widget.posts.length, // Number of widget.posts
        itemBuilder: (context, index) {
          print("widget.posts");

          print(widget.posts);
          return buildPostCard(widget.posts[index]);
        },
      );
    }
  }

  Widget buildPostCard(ArticleModel post) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 5.0),
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      color: Colors.red,
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
                post.media != null
                    ? const SizedBox.shrink()
                    : const SizedBox(height: 6),
              ],
            ),
          ),
          post.media != null && post.media!.isNotEmpty
              ? Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8),
                  child:
                      CachedNetworkImage(imageUrl: post!.media?[0].path ?? ''),
                )
              : const SizedBox.shrink(),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            child: _PostStats(post: post), // Pass the post to _PostStats
          ),
        ],
      ),
    );
  }
}

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
          backgroundImage: NetworkImage(post.media?[0].path ??
              ''), // Assuming imageUrl is the user's profile image URL
        ),
        SizedBox(width: 8),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                // post.owner!.fullName,
                'amit',
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
  const _PostStats({
    Key? key,
    required this.post,
  }) : super(key: key);

  final ArticleModel post;

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
              '${post.likes?.length}',
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
              onTap: () => print('Like'),
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
