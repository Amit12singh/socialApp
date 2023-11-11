import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:myapp/models/article_model.dart';
import 'package:myapp/models/chat_model.dart';
import 'package:myapp/models/user_model.dart';
import 'package:myapp/models/user_profile_model.dart';
import 'package:myapp/page-1/ChatScreen.dart';
import 'package:myapp/page-1/createpostScreen.dart';
import 'package:myapp/page-1/messagelist.dart';
import 'package:myapp/page-1/feeds/homescreen.dart';
import 'package:myapp/page-1/feeds/postScreen.dart';
import 'package:myapp/page-1/login.dart';
import 'package:myapp/page-1/seeMoreText.dart';
import 'package:myapp/services/article_service.dart';
import 'package:myapp/services/user_service.dart';
import 'package:myapp/utilities/localstorage.dart';
import 'package:myapp/widgets/commentPage.dart';
import 'package:page_transition/page_transition.dart';
import 'package:myapp/widgets/avatarWithbutton.dart';
import 'package:timeago/timeago.dart' as timeago;

class ProfileScreen extends StatefulWidget {
  final UserModel? user;
  const ProfileScreen({Key? key, this.user}) : super(key: key);

  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen>
    with SingleTickerProviderStateMixin {
  final HandleToken localStorageService = HandleToken();
  final GraphQLService userService = GraphQLService();

  bool isExpanded = false;
  UserTimelineModel? posts;
  TabController? _tabController;
  ChatModel? receiver;

  var _user = null;

  get selectedIndex => null;

  final List<Widget> pages = [
    const ProfileScreen(),
    const FeedScreen(),
    const MessengerPage(),
  ];

  void _handleLogout(BuildContext context) async {
    bool isCleared = await localStorageService.clearAccessToken();

    if (isCleared) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
            'Logged out successfully',
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.black,
            ),
          ),
          backgroundColor: Colors.green,
          behavior: SnackBarBehavior.floating,
        ),
      );

      Navigator.of(context).pushAndRemoveUntil(
        PageTransition(
            type: PageTransitionType.scale,
            alignment: Alignment.bottomCenter,
            child: LoginScreen()),
        (Route<dynamic> route) => false,
      );
    }
  }

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);

    _loadData();
  }

  void _loadData() async {
    final user = await localStorageService.getUser();
    _user = widget.user ?? user;
    receiver = widget.user != null && user?.id != _user.id
        ? ChatModel(id: _user.id ?? '', name: _user?.fullName ?? '')
        : null;

    posts = await userService.userProfile(id: _user.id);
    setState(() {
      _user = user;
    });
  }

  @override
  void dispose() {
    _tabController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: DefaultTabController(
        initialIndex: 1,
        length: 2,
        child: NestedScrollView(
          physics: const NeverScrollableScrollPhysics(),
          headerSliverBuilder: (context, isScrolled) {
            return [
              SliverAppBar(
                backgroundColor: Colors.white,
                collapsedHeight: 300,
                expandedHeight: 200,
                flexibleSpace:
                    ProfileView(userTimeline: posts, receiver: receiver),
              ),
              SliverPersistentHeader(
                delegate: MyDelegate(
                  TabBar(
                    controller: _tabController,
                    onTap: ((value) {
                      if (value == 1 && receiver != null) {
                        Navigator.push(
                          context,
                          PageTransition(
                            type: PageTransitionType.scale,
                            alignment: Alignment.bottomCenter,
                            child: ChatScreen(
                                receiver: receiver ?? {} as ChatModel),
                          ),
                        );
                      }
                    }),
                    tabs: const [
                      Tab(
                        icon: Icon(Icons.grid_on),
                        text: 'Timeline',
                      ),
                    ],
                    indicatorColor: Colors.black,
                    unselectedLabelColor: Colors.grey,
                    labelColor: Colors.black,
                  ),
                ),
                floating: true,
                pinned: true,
              ),
            ];
          },
          body: ProfilePostScreen(posts: posts?.timeline, load: _loadData),
        ),
      ),
    );
  }
}

class MyDelegate extends SliverPersistentHeaderDelegate {
  MyDelegate(this.tabBar);

  final TabBar tabBar;

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return Container(
      color: Colors.white,
      child: tabBar,
    );
  }

  @override
  double get maxExtent => tabBar.preferredSize.height;

  @override
  double get minExtent => tabBar.preferredSize.height;

  @override
  bool shouldRebuild(SliverPersistentHeaderDelegate oldDelegate) {
    return false;
  }
}

class ProfileView extends StatelessWidget {
  UserTimelineModel? userTimeline;
  ChatModel? receiver;
  GraphQLService userService = GraphQLService();

  ProfileView({Key? key, this.userTimeline, this.receiver})
      : super(
          key: key,
        );

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Container(
            color: Colors.white,
            height: 120,
            width: 130,
            // child: Avatar(user: userTimeline?.profile)),
            child: profileAvatar(
                isCurrentUser: receiver != null ? false : true,
                imageUrl: userTimeline?.profile.profilePicture?.path ??
                    'assets/page-1/images/ellipse-1-bg-gnM.png'),
          ),
          Column(
            children: [
              Text(
                userTimeline?.totalPosts.toString() ?? 'No posts yet.',
                style: const TextStyle(
                  fontSize: 16,
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(
                height: 4,
              ),
              const Text('Posts'),
            ],
          ),
          Column(
            children: [
              Text(
                userTimeline?.totalLikes.toString() ?? 'No likes yet.',
                style: const TextStyle(
                  fontSize: 16,
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(
                height: 4,
              ),
              const Text('Likes'),
            ],
          ),
        ],
      ),
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  userTimeline?.profile.fullName ?? '',
                  style: const TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                  ),
                ),
                const SizedBox(height: 3),
                const Text(
                  'Old Nabhaites',
                  style: TextStyle(
                    color: Colors.black87,
                    fontSize: 16,
                  ),
                ),
                const SizedBox(height: 3),

                Row(
                  children: [
                    const Text(
                      "Lives in :",
                      style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.w400,
                        fontSize: 16,
                      ),
                    ),
                    const SizedBox(
                      width: 5,
                    ),
                    Text(
                      userTimeline?.profile.currentCity ?? '',
                      style: const TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.w400,
                        fontSize: 16,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 3),

                Row(
                  children: [
                    const Text(
                      "Contact :",
                      style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.w400,
                        fontSize: 16,
                      ),
                    ),
                    const SizedBox(
                      width: 5,
                    ),
                    Text(
                      userTimeline?.profile.phoneNumber ?? '',
                      style: const TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.w400,
                        fontSize: 16,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 3),

                Row(
                  children: [
                    const Text(
                      "Passedout in:",
                      style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.w400,
                        fontSize: 16,
                      ),
                    ),
                    const SizedBox(
                      width: 5,
                    ),
                    Text(
                      userTimeline?.profile.passedOutYear ?? '',
                      style: const TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.w400,
                        fontSize: 16,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 3),

                Row(
                  children: [
                    const Text(
                      "House/House no. :",
                      style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.w400,
                        fontSize: 16,
                      ),
                    ),
                    const SizedBox(
                      width: 5,
                    ),
                    Text(
                      '${userTimeline?.profile.house ?? ' '},${userTimeline?.profile.houseNumber ?? ' '}',
                      style: const TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.w400,
                        fontSize: 16,
                      ),
                    )
                  ],
                )
                 
              ],
            ),
          ],
        ),
      ),
      const SizedBox(
        height: 5,
      ),
      receiver != null
          ? Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              child: Row(
                children: [
                  Expanded(
                    child: TextButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          PageTransition(
                            type: PageTransitionType.scale,
                            alignment: Alignment.bottomCenter,
                            child: ChatScreen(
                                receiver: receiver ?? {} as ChatModel),
                          ),
                        );
                      },
                      style: TextButton.styleFrom(
                        backgroundColor: const Color(
                            0xFF0077b5), // Set the background color to blue
                      ),
                      child: const Text(
                        'Message',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                ],
              ),
            )
          : const SizedBox(),
    ]));
  }
}

class ProfilePostScreen extends StatefulWidget {
  final List<ArticleModel>? posts;
  final Function load;

  const ProfilePostScreen({Key? key, required this.posts, required this.load})
      : super(key: key);

  @override
  _PostScreenState createState() => _PostScreenState();
}

class _PostScreenState extends State<ProfilePostScreen> {
  final _postService = PostService();
  final currentUser = HandleToken().getUser();

  @override
  void initState() {
    super.initState();
  }

  Future<bool> isAlreadyLiked() async {
    final currentUser = await HandleToken().getUser();

    widget.posts?.forEach((e) {
      if (currentUser != null && e.likes != null) {
        e.likes?.any((like) => like.user!.id == currentUser.id) ?? false;
      }
    });

    return false;
  }

  onDelete(String postId) async {
    final isDeleted = await _postService.deleteArticle(postId);
    if (isDeleted) {
      widget.load();
    }
  }

  @override
  Widget build(BuildContext context) {
    if (widget.posts == null) {
      return const Center(
        child: CircularProgressIndicator(),
      );
    } else {
      if (widget.posts!.isEmpty) {
        return const Padding(
          padding: EdgeInsets.only(left: 10, right: 4),
          child: Column(
            children: [
              SizedBox(height: 20),
              Center(
                child: Text(
                  'No Posts yet.',
                  style: TextStyle(fontSize: 24),
                ),
              )
            ],
          ),
        );
      }
      return ListView.builder(
        itemCount: widget.posts?.length,
        itemBuilder: (context, index) {
          return buildPostCard(widget.posts![index]);
        },
      );
    }
  }

  Widget buildPostCard(ArticleModel post) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 5.0),
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      color: const Color(0xFFFFFFFF),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                _PostHeader(post: post, onDelete: onDelete),
                const SizedBox(height: 4.0),
                SeeMoreText(text: post.title),
                if (post.media != null && post.media!.isNotEmpty)
                  const SizedBox(height: 6),
              ],
            ),
          ),
          if (post.media != null && post.media!.isNotEmpty)
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8),
              child: Image.network(
                Uri.parse(post.media![0].path ?? '').toString(),
                loadingBuilder: (BuildContext context, Widget child,
                    ImageChunkEvent? loadingProgress) {
                  if (loadingProgress == null) {
                    return child;
                  } else {
                    return Center(
                      child: CircularProgressIndicator(
                        value: loadingProgress.expectedTotalBytes != null
                            ? loadingProgress.cumulativeBytesLoaded /
                                loadingProgress.expectedTotalBytes!
                            : null,
                      ),
                    );
                  }
                },
              ),
            )
          else
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
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
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
  const _PostHeader({
    Key? key,
    required this.post,
    required this.onDelete,
  }) : super(key: key);

  final ArticleModel post;
  final Function(String) onDelete;

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
              Text(
                '${post.owner?.fullName}',
                style:
                    const TextStyle(fontWeight: FontWeight.w600, fontSize: 16),
              ),
              const SizedBox(
                height: 6,
              ),
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
                  ),
                ],
              ),
            ],
          ),
        ),
        PopupMenuButton<String>(
          icon: const Icon(
            Icons.more_horiz,
            color: Color.fromARGB(255, 167, 135, 135),
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
        ),
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
  late UserModel loggedInUser;
  bool isRendered = false;

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
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Text(
                  likeCount.toString(),
                  style: TextStyle(color: Colors.grey[600], fontSize: 14),
                ),
                const SizedBox(width: 4),
                Container(
                  padding: const EdgeInsets.all(4.0),
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                  ),
                  child: likeCount > 0
                      ? const Icon(
                          Icons.thumb_up_sharp,
                          color: Color.fromARGB(255, 167, 135, 135),
                          size: 15,
                        )
                      : const SizedBox(),
                ),
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
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            _PostButton(
              icon: Icon(
                Icons.thumb_up_sharp,
                color: _isLiked
                    ? const Color.fromARGB(255, 167, 135, 135)
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
            const SizedBox(
              width: 8,
            ),
            _PostButton(
              icon: const Icon(
                Icons.insert_comment_outlined,
                size: 25,
              ),
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
              width: 8,
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
