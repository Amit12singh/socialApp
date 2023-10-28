// ignore_for_file: unnecessary_string_interpolations

import 'package:flutter/material.dart';
import 'package:myapp/models/article_model.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:myapp/models/user_model.dart';
import 'package:myapp/services/article_service.dart';
import 'package:myapp/utilities/localstorage.dart';

class PostScreen extends StatefulWidget {
  final List<ArticleModel> posts;

  const PostScreen({Key? key, required this.posts}) : super(key: key);

  @override
  _PostScreenState createState() => _PostScreenState();
}

class _PostScreenState extends State<PostScreen> {
  final _postService = PostService();
  bool _isLiked = false;
  final currentUser = HandleToken().getUser();

  @override
  void initState() {
    super.initState();
    
  }

  // Future<bool> isAlreadyLiked() async {
  //   final currentUser = await HandleToken().getUser();

  //   widget.posts.forEach((e) {
  //     if (currentUser != null && e.likes != null) {
  //       e.likes?.any((like) => like.user?.id == currentUser.id) ?? false;
  //     }
  //   });

  //   return false;
  // }

 

  

  @override
  Widget build(BuildContext context) {
    if (widget.posts.isEmpty) {
      return const Center(
        child: CircularProgressIndicator(),
      );
    } else {
      return ListView.builder(
        itemCount: widget.posts.length,
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
      color: const Color.fromARGB(255, 255, 255, 255),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                _PostHeader(post: post),
                const SizedBox(
                  height: 8.0,
                ),
                Text(post.title),
                post.media == null
                    ? const SizedBox.shrink()
                    : const SizedBox(height: 6),
              ],
            ),
          ),
          post.media != null && post.media!.isNotEmpty
              ? Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8),
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      FutureBuilder<void>(
                        future: precacheImage(
                          NetworkImage(
                              Uri.parse(post.media![0].path ?? '').toString()),
                          context,
                        ),
                        builder: (BuildContext context,
                            AsyncSnapshot<void> snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            return Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(22),
                                image: const DecorationImage(
                                  fit: BoxFit.contain,
                                  image: AssetImage(
                                      'assets/page-1/images/defaultimage.jpg'),
                                ),
                              ),
                            ); // Show loading spinner
                          } else if (snapshot.hasError) {
                            return Text('Error loading image');
                          } else {
                            return Image.network(
                              Uri.parse(post.media![0].path ?? '').toString(),
                            );
                          }
                        },
                      ),
                    ],
                  ),
                )
              : Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(22),
                    image: const DecorationImage(
                      fit: BoxFit.contain,
                      image:
                          AssetImage('assets/page-1/images/defaultimage.jpg'),
                    ),
                  ),
                ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            child: _PostStats(
              post: post,
              postService: _postService,
              isPostLiked: _isLiked,
            ),
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
        Avatar(user: post.owner),
        const SizedBox(width: 8),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(children: [
                Text(
                  '${post.owner?.fullName}',
                  style: const TextStyle(
                      fontWeight: FontWeight.w500, fontSize: 17),
                ),
              ]),
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

class _PostStats extends StatefulWidget {
  const _PostStats({
    Key? key,
    required this.post,
    required this.postService,
    required this.isPostLiked,
  }) : super(key: key);

  final ArticleModel post;
  final postService;
  final bool isPostLiked;

  @override
  _PostStatsState createState() => _PostStatsState();
}

class _PostStatsState extends State<_PostStats> {
  bool _isLiked = false;
  int likeCount = 0;
  bool _hasExecuted = false;
  bool currentLike = false;

  @override
  void initState() {
    super.initState();
    likeCount = widget.post.totalLikes;
    if (!_hasExecuted) {
      _isAlreadyLiked();
      _hasExecuted = true;
    }
  }

  void _isAlreadyLiked() async {
    print("run $_isLiked");
    final currentUser = await HandleToken().getUser();

    if (currentUser != null && widget.post.likes != null) {
      // Check if any like by the current user exists
      bool isLiked =
          widget.post.likes!.any((like) => like.user?.id == currentUser.id);

      setState(() {
        _isLiked = isLiked;
      });
    } else {
      setState(() {
        _isLiked =
            false; // Set _isLiked to false if there is no current user or likes list is null.
      });
    }
  }

  _likePost(String articleId) async {
    await widget.postService.likePost(articleId);

    
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Container(
              padding: const EdgeInsets.all(4.0),
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
              ),
              child: Icon(
                widget.isPostLiked
                    ? Icons.favorite
                    : Icons.favorite_border_rounded,
                size: 10,
                color: _isLiked ? Colors.red : Colors.white,
              ),
            ),
            const SizedBox(width: 4),
            Text(
              '${likeCount}',
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
                _isLiked ? Icons.favorite : MdiIcons.heartOutline,
                color: _isLiked ? Colors.red : Colors.grey[600],
                size: 20,
              ),
              label: 'Like',
              onTap: () {
                setState(() {
                  if (_isLiked) {
                    likeCount--;
                  } else {
                    likeCount++;
                  }
                  _isLiked = !_isLiked;
                  _likePost(widget.post.id ?? '');
                });
              },
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

class Avatar extends StatelessWidget {
  final Key? key;
  final UserModel? user;

  Avatar({
    this.key,
    required this.user,
  });

  @override
  Widget build(BuildContext context) {
    if (user?.profilePicture != null) {
      return CircleAvatar(
          backgroundImage: NetworkImage(user!.profilePicture!.path ?? ''),
          backgroundColor: Colors.transparent,
          radius: 28);
    } else {
      return const CircleAvatar(
          backgroundImage:
              AssetImage('assets/page-1/images/ellipse-1-bg-gnM.png'),
          backgroundColor: Colors.transparent,
          radius: 28);
    }
  }
}
