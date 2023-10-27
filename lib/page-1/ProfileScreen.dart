import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:myapp/models/article_model.dart';
import 'package:myapp/models/chat_model.dart';
import 'package:myapp/models/user_model.dart';
import 'package:myapp/models/user_profile_model.dart';
import 'package:myapp/page-1/ChatScreen.dart';
import 'package:myapp/page-1/messagelist.dart';
import 'package:myapp/page-1/ChatScreen.dart';
import 'package:myapp/page-1/feeds/bottombar.dart';
import 'package:myapp/page-1/feeds/homescreen.dart';
import 'package:myapp/page-1/feeds/post.dart';
import 'package:myapp/page-1/login.dart';
import 'package:myapp/services/article_service.dart';
import 'package:myapp/services/user_service.dart';
import 'package:myapp/utilities/localstorage.dart';
import 'package:myapp/page-1/ChatScreen.dart';

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
  late ChatModel receiver;

  var _user = null;

  get selectedIndex => null;

  final List<Widget> pages = [
    ProfileScreen(),
    FeedScreen(),
    MessengerPage(),
  ];

  void _handleLogout(BuildContext context) async {
    bool isCleared = await localStorageService.clearAccessToken();

    if (isCleared) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            'Logged out successfully',
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.black,
            ),
          ),
          backgroundColor: Colors.green,
        ),
      );

      Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(builder: (context) => LoginScreen()),
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
    final user = widget.user ?? await localStorageService.getUser();
    _user = user;
    receiver =
        ChatModel(id: widget.user?.id ?? '', name: widget.user?.fullName ?? '');

    posts = await userService.userProfile(id: _user.id);
    setState(() {
      // posts = _posts;
      _user = user;
    });
  }

  @override
  void dispose() {
    _tabController?.dispose(); // Dispose of the TabController when not needed
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        systemOverlayStyle: SystemUiOverlayStyle(
          // Status bar color
          statusBarColor: Colors.white,
          statusBarIconBrightness: Brightness.dark, // For Android (dark icons)
          statusBarBrightness: Brightness.light, // For iOS (dark icons)
        ),
        elevation: 0,
        backgroundColor: Colors.white,
        leading: IconButton(
          icon: Container(
            width: 60,
            height: 60,
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
            ),
            child: Image.asset(
              'assets/page-1/images/ellipse-1-bg.png',
              width: 45,
              height: 45,
            ),
          ),
          onPressed: () {},
        ),
        titleSpacing: 3,
        title: const Text(
          'PPSONA',
          style: TextStyle(
            color: const Color(0xFFA78787),
            decoration: TextDecoration.none,
            fontFamily: 'PermanentMarker-Regular',
            fontWeight: FontWeight.bold,
            fontSize: 25,
          ),
        ),
        actions: [
          PopupMenuButton<String>(
            icon: const Icon(
              Icons.more_vert,
              color: Colors.black,
            ),
            onSelected: (value) {
              if (value == 'log_out') {
                _handleLogout(context);
              }
            },
            itemBuilder: (BuildContext context) {
              return <PopupMenuEntry<String>>[
                const PopupMenuItem<String>(
                  value: 'log_out',
                  child: ListTile(
                    leading: Icon(Icons.exit_to_app),
                    title: Text('Log Out'),
                  ),
                ),
              ];
            },
          ),
        ],
      ),
      body: DefaultTabController(
        initialIndex: 1,
        length: 2,
        child: NestedScrollView(
          physics: const NeverScrollableScrollPhysics(),
          headerSliverBuilder: (context, isScrolled) {
            return [
              SliverAppBar(
                backgroundColor: Colors.white,
                collapsedHeight: 180,
                expandedHeight: 180,
                flexibleSpace: ProfileView(userTimeline: posts),
              ),
              SliverPersistentHeader(
                delegate: MyDelegate(
                  TabBar(
                    controller: _tabController,
                    onTap: ((value) {
                      if (value == 1 && receiver != null) {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                ChatScreen(receiver: receiver),
                          ),
                        );
                      }
                    }),
                    tabs: [
                      const Tab(
                        icon: Icon(Icons.grid_on),
                        text: 'Timeline',
                      ),
                      widget.user != null
                          ? const Tab(
                              icon: Icon(
                                  Icons.messenger), // Add your new icon here
                              text: 'Messenger',
                            )
                          : const SizedBox(),
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
          body: ProfilePostScreen(
              posts: posts?.timeline,
              load: _loadData), // Provide your posts data
        ),
      ),
      bottomNavigationBar: const Bottombar(),
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

  ProfileView({Key? key, this.userTimeline})
      : super(
          key: key,
        );

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            margin: const EdgeInsets.symmetric(vertical: 16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Container(
                    height: 80,
                    width: 80,
                    child: Avatar(user: userTimeline?.profile)),
                Column(
                  children: [
                    Text(
                      userTimeline?.totalPosts.toString() ?? '0',
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
                      userTimeline?.totalLikes.toString() ?? '0',
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
          ),
          Container(
            margin: const EdgeInsets.only(left: 20),
            child: RichText(
              text: TextSpan(
                children: [
                  TextSpan(
                    text: userTimeline?.profile.fullName,
                    style: const TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                  const TextSpan(
                    text: '\nOld Nabhaies\n',
                    style: const TextStyle(
                      color: Colors.black87,
                      fontSize: 14,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
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
  bool _isLiked = false;
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

  _likePost(String articleId) async {
    final isLiked = await _postService.likePost(articleId);

    setState(() {
      _isLiked = isLiked;
    });
  }

  onDelete(String postId) async {
    print('id $postId');
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
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                _PostHeader(post: post, onDelete: onDelete),
                const SizedBox(
                  height: 4.0,
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
                  child: Image.network(
                    Uri.parse(post.media?[0].path ?? '').toString(),
                    loadingBuilder: (BuildContext context, Widget child,
                        ImageChunkEvent? loadingProgress) {
                      if (loadingProgress == null) {
                        return child; // Image is fully loaded, display it
                      } else {
                        // Show a CircularProgressIndicator while loading
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
              : const SizedBox.shrink(),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            child: _PostStats(
              post: post,
              likePost: _likePost,
              isPostLiked: _isLiked,
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
    // required this.onEdit,
    required this.onDelete,
  }) : super(key: key);

  final ArticleModel post;
  // final Function() onEdit;
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
                  ),
                ],
              ),
            ],
          ),
        ),
        PopupMenuButton<String>(
          icon: const Icon(
            Icons.more_horiz,
            color: Colors.black,
          ),
          onSelected: (value) {
            if (value == 'edit') {
              // onEdit();
              () {};
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
                // onTap: () {},
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

  // void onEdit() {
  //   ScaffoldMessenger.of(context).showSnackBar(
  //     SnackBar(
  //       content: Text('Editing post...'),
  //     ),
  //   );

  //   ScaffoldMessenger.of(context).showSnackBar(
  //     SnackBar(
  //       content: Text('Post edited successfully'),
  //     ),
  //   );
  // }

  // void onDelete() {
  //   ScaffoldMessenger.of(context).showSnackBar(
  //     SnackBar(
  //       content: Text('Deleting post...'),
  //       action: SnackBarAction(
  //         label: 'Undo',
  //         onPressed: () {
  //           ScaffoldMessenger.of(context).showSnackBar(
  //             SnackBar(
  //               content: Text('Deletion undone'),
  //             ),
  //           );
  //         },
  //       ),
  //     ),
  //   );
  //   ScaffoldMessenger.of(context).showSnackBar(
  //     SnackBar(
  //       content: Text('Post deleted successfully'),
  //     ),
  //   );
  // }
}

class _PostStats extends StatefulWidget {
  const _PostStats({
    Key? key,
    required this.post,
    required this.likePost,
    required this.isPostLiked,
  }) : super(key: key);

  final ArticleModel post;
  final Function likePost;
  final bool isPostLiked;

  @override
  _PostStatsState createState() => _PostStatsState();
}

class _PostStatsState extends State<_PostStats> {
  bool _isLiked = false;
  int _likeCount = 0;

  @override
  void initState() {
    super.initState();
    _isLiked = widget.isPostLiked;
    _likeCount = widget.post.totalLikes;
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
                _isLiked ? Icons.favorite : Icons.favorite_border_rounded,
                size: 10,
                color: _isLiked ? Colors.red : Colors.white,
              ),
            ),
            const SizedBox(width: 4),
            Text(
              '$_likeCount',
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
                MdiIcons.heartOutline,
                color: _isLiked ? Colors.red : Colors.grey[600],
                size: 20,
              ),
              label: 'Like',
              onTap: () {
                setState(() {
                  if (_isLiked) {
                    _likeCount--;
                  } else {
                    _likeCount++;
                  }
                  _isLiked = !_isLiked;
                  widget.likePost(widget.post.id);
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
