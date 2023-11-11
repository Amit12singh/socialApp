// ignore_for_file: unnecessary_string_interpolations
import 'package:flutter/material.dart';
import 'package:myapp/models/article_model.dart';
import 'package:myapp/models/user_model.dart';
import 'package:myapp/page-1/createpostScreen.dart';
import 'package:myapp/page-1/seeMoreText.dart';
import 'package:myapp/services/article_service.dart';
import 'package:myapp/utilities/localstorage.dart';
import 'package:myapp/page-1/ProfileScreen.dart';
import 'package:myapp/widgets/commentPage.dart';
import 'package:page_transition/page_transition.dart';
import 'package:timeago/timeago.dart' as timeago;

class PostScreen extends StatefulWidget {
  const PostScreen({
    Key? key,
  }) : super(key: key);

  @override
  _PostScreenState createState() => _PostScreenState();
}

class _PostScreenState extends State<PostScreen> {
  final _postService = PostService();

  late UserModel? _currentUser;
  List<ArticleModel> posts = [];

  @override
  void initState() {
    super.initState();
    _loadUser();
    _loadData();
  }

  void _loadUser() async {
    final UserModel? currentUser = await HandleToken().getUser();
    setState(() {
      _currentUser = currentUser;
    });
  }

  void _loadData() async {
    final List<ArticleModel> _posts = await _postService.getArticles();
    print(_posts);
    setState(() {
      posts = _posts as List<ArticleModel>;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (posts.isEmpty) {
      return const Center(
        child: CircularProgressIndicator(),
      );
    } else {
      return ListView.builder(
        itemCount: posts.length,
        itemBuilder: (context, index) {
          return buildPostCard(posts[index]);
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
                _PostHeader(post: post, owner: _currentUser, load: _loadData),
                const SizedBox(
                  height: 8.0,
                ),
                SeeMoreText(
                  text: post.title,
                  maxLines: 4,
                ),
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
                              width: 100,
                              height: 100,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(22),
                                color: Colors.grey[300],
                              ),
                              child: const Center(
                                child: CircularProgressIndicator(),
                              ),
                            );
                          } else if (snapshot.hasError) {
                            return Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(22),
                                image: const DecorationImage(
                                  fit: BoxFit.contain,
                                  image: AssetImage(
                                      'assets/page-1/images/defaultimage.jpg'),
                                ),
                              ),
                            );
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
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(22),
              image: const DecorationImage(
                fit: BoxFit.contain,
                image: AssetImage('assets/page-1/images/defaultimage.jpg'),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
            child: _PostStats(
              post: post,
              postService: _postService,
            ),
          ),
        ],
      ),
    );
  }
}

class _PostHeader extends StatelessWidget {
  _PostHeader(
      {Key? key, required this.post, required this.owner, required this.load})
      : super(key: key);
  final ArticleModel post;
  final UserModel? owner;
  final Function load;
  final PostService postService = PostService();

  onDelete(String postId) async {
    final isDeleted = await postService.deleteArticle(postId);
    if (isDeleted) {
      load();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              PageTransition(
                type: PageTransitionType.scale,
                alignment: Alignment.bottomCenter,
                child: ProfileScreen(
                  user: post.owner,
                ),
              ),
            );
          },
          child: Avatar(user: post.owner),
        ),
        const SizedBox(width: 8),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(children: [
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      PageTransition(
                        type: PageTransitionType.scale,
                        alignment: Alignment.bottomCenter,
                        child: ProfileScreen(
                          user: post.owner,
                        ),
                      ),
                    );
                  },
                  child: Text(
                    '${post.owner?.fullName}',
                    style: const TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: 17,
                    ),
                  ),
                ),
                const SizedBox(height: 30),
              ]),
              Row(
                children: [
                  Text(
                    timeago.format(
                      post.createdAt, // Your DateTime object
                      locale: 'en', // Use the same locale as set in step 3
                    ),
                  ),
                  const SizedBox(width: 10),
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
        post.owner?.id == owner?.id
            ? PopupMenuButton<String>(
                icon: const Icon(
                  Icons.more_horiz,
                  color: Colors.black,
                ),
                onSelected: (value) {
                  if (value == 'edit') {
                    Navigator.of(context).push(
                      PageTransition(
                        type: PageTransitionType.scale,
                        alignment: Alignment.bottomCenter,
                        child: CreatePostScreen(
                          post: post,
                          user: post.owner,
                        ),
                      ),
                    );
                  } else if (value == 'delete') {
                    onDelete(post.id ?? '');
                  }
                },
                itemBuilder: (BuildContext context) {
                  return <PopupMenuEntry<String>>[
                    const PopupMenuItem<String>(
                      value: 'edit',
                      child: ListTile(
                        leading: Icon(Icons.edit),
                        title: Text('Edit'),
                      ),
                    ),
                    const PopupMenuItem<String>(
                      value: 'delete',
                      child: ListTile(
                        leading: Icon(Icons.delete),
                        title: Text('Delete'),
                      ),
                    ),
                  ];
                },
              )
            : const SizedBox()
      ],
    );
  }
}

class _PostStats extends StatefulWidget {
  _PostStats({
    Key? key,
    required this.post,
    required this.postService,
  }) : super(key: key);

  final ArticleModel post;

  final postService;

  @override
  _PostStatsState createState() => _PostStatsState();
}

class _PostStatsState extends State<_PostStats> {
  bool _isLiked = false;
  int likeCount = 0;
  bool isRendered = false;
  late UserModel loggedInUser;

  @override
  void initState() {
    super.initState();
    likeCount = widget.post.totalLikes;
    _isAlreadyLiked();
  }

  void _isAlreadyLiked() async {
    final currentUser = await HandleToken().getUser();

    if (currentUser != null &&
        widget.post.likes != null &&
        isRendered == false) {
      bool isLiked =
          widget.post.likes!.any((like) => like.user?.id == currentUser.id);

      isRendered = true;
      setState(() {
        _isLiked = isLiked;
        loggedInUser = currentUser;
      });
    }
    if (widget.post.totalLikes - 1 == widget.post.likes!.length && isRendered) {
      setState(() {
        _isLiked = true;
      });
    }

    if (widget.post.totalLikes < widget.post.likes!.length &&
        isRendered == true) {
      setState(() {
        _isLiked = false;
      });
    }
  }

  _likePost(String articleId) async {
    await widget.postService.likePost(articleId);

    widget.post.updateLikes(likeCount);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: 10),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Text(
                  likeCount > 0 ? likeCount.toString() : 'No likes yet.',
                  style: TextStyle(
                    color: Colors.grey[600],
                  ),
                ),
                const SizedBox(width: 4),
                Container(
                    padding: const EdgeInsets.all(4.0),
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(
                      Icons.thumb_up_sharp,
                      color: Color.fromARGB(255, 167, 135, 135),
                      size: 15,
                    )),
              ],
            ),
            widget.post.comments!.isNotEmpty
                ? Text(
                    widget.post.comments!.length.toString() + ' comments' ?? '')
                : const Text("No comments yet.")
          ],
        ),
        const Divider(),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _PostButton(
              icon: Icon(
                Icons.thumb_up_sharp,
                color: _isLiked
                    ? Color.fromARGB(255, 167, 135, 135)
                    : Colors.grey[600],
                size: 25,
              ),
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
            const Spacer(),
            _PostButton(
              icon: Icon(Icons.insert_comment_outlined,
                  color: Colors.grey[600], size: 25),
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => CommentScreen(
                        loggedInUser: loggedInUser, post: widget.post),
                  ),
                );
              },
            ),
            const SizedBox(
              width: 16,
            )
          ],
        ),
      ],
    );
  }
}

class _PostButton extends StatelessWidget {
  final Key? key;
  final Icon icon;
  final Function() onTap;

  _PostButton({
    this.key,
    required this.icon,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
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
            ],
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
        radius: 28,
      );
    } else {
      return const CircleAvatar(
          backgroundImage:
              AssetImage('assets/page-1/images/ellipse-1-bg-gnM.png'),
          backgroundColor: Colors.transparent,
          radius: 28);
    }
  }
}
