import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:myapp/models/article_model.dart';
import 'package:myapp/models/chat_model.dart';
import 'package:myapp/models/user_model.dart';
import 'package:myapp/models/user_profile_model.dart';
import 'package:myapp/page-1/ChatScreen.dart';
import 'package:myapp/page-1/createpostScreen.dart';
import 'package:myapp/page-1/messagelist.dart';
import 'package:myapp/page-1/feeds/bottombar.dart';
import 'package:myapp/page-1/feeds/homescreen.dart';
import 'package:myapp/page-1/feeds/post.dart';
import 'package:myapp/page-1/login.dart';
import 'package:myapp/services/article_service.dart';
import 'package:myapp/services/user_service.dart';
import 'package:myapp/utilities/localstorage.dart';

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
       widget.user != null
        ? ChatModel(
            id: widget.user?.id ?? '', name: widget.user?.fullName ?? '')
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
      appBar: AppBar(
        systemOverlayStyle: const SystemUiOverlayStyle(
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
                          MaterialPageRoute(
                            builder: (context) =>
                                ChatScreen(
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
      bottomNavigationBar: Bottombar(
        onIconPressed: () {
          final currentRoute = ModalRoute.of(context);
          if (currentRoute != null && currentRoute.settings.name == '/search') {
            return;
          }

          Navigator.pushNamed(context, '/search');
        },
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
  

  ProfileView({Key? key, this.userTimeline, this.receiver})
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
                const SizedBox(height: 2), // Add a 25-pixel vertical gap
                const Text(
                  'Old Nabhaies',
                  style: TextStyle(
                    color: Colors.black87,
                    fontSize: 15,
                  ),
                ),
              ],
            ),
            receiver != null
                ? Align(
                    alignment: Alignment.topCenter,
                    child: TextButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => ChatScreen(
                                receiver: receiver ?? {} as ChatModel),
                          ),
                        );
                      },
                      style: TextButton.styleFrom(
                        backgroundColor:
                            Colors.blue, // Set the background color to blue
                      ),
                      child: const Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          SizedBox(
                            width:
                                8, // Add some space between the icon and text
                          ),
                          Text(
                            'Message',
                            style: TextStyle(color: Colors.white),
                          ),
                        ],
                      ),
                    ),
                  )
                : const SizedBox()
          ],
        ),
      )
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
                Text(post.title),
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
            padding: const EdgeInsets.symmetric(horizontal: 12),
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
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => CreatePostScreen(post: post),
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
          children: [
            Text(
              likeCount.toString(),
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
              child: likeCount > 0
                  ? const Icon(
                      Icons.favorite,
                      size: 15,
                      color: Colors.red,
                    )
                  : const SizedBox(),
            ),
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
