import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:myapp/models/article_model.dart';
import 'package:myapp/models/user_profile_model.dart';
import 'package:myapp/page-1/feeds/bottombar.dart';
import 'package:myapp/page-1/login.dart';
import 'package:myapp/services/article_service.dart';
import 'package:myapp/services/user_service.dart';
import 'package:myapp/utilities/localstorage.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final HandleToken localStorageService = HandleToken();
  final GraphQLService userService = GraphQLService();

  bool isExpanded = false;
  List<UserTimelineModel>? posts;

  var _user = null;

  void _handleLogout() async {
    bool isCleared = await localStorageService.clearAccessToken();

    if (isCleared) {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => LoginScreen()),
      );
    }
  }

  @override
  void initState() {
    super.initState();

    _loadData();
  }

  void _loadData() async {
    final user = await localStorageService.getUser();
    _user = user;
    final List _posts = await userService.userProfile(id: _user.id);
    print('get user profile');
    print('get user profile $_posts');
    setState(() {
      posts = _posts.cast<UserTimelineModel>();
      _user = user;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
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
          onPressed: () {
            // Handle the action when the circular icon is tapped
          },
        ),
        titleSpacing: 3,
        title: const Text(
          'PPSONA',
          style: TextStyle(
            color: Color(0xFFA78787),
            decoration: TextDecoration.none,
            fontFamily: 'PermanentMarker-Regular',
            fontWeight: FontWeight.bold,
            fontSize: 25,
          ),
        ),
        actions: [
          PopupMenuButton<String>(
            icon: Icon(
              Icons.more_vert,
              color: Colors.black,
            ),
            onSelected: (value) {
              if (value == 'log_out') {
                _handleLogout();
              }
            },
            itemBuilder: (BuildContext context) {
              return <PopupMenuEntry<String>>[
                PopupMenuItem<String>(
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
        length: 1,
        child: NestedScrollView(
          physics: const NeverScrollableScrollPhysics(),
          headerSliverBuilder: (context, isScrolled) {
            return [
              SliverAppBar(
                backgroundColor: Colors.white,
                collapsedHeight: 180,
                expandedHeight: 180,
                flexibleSpace: const ProfileView(),
              ),
              SliverPersistentHeader(
                delegate: MyDelegate(
                  TabBar(
                    tabs: [
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
          body: ProfilePostScreen(
              posts: posts?[0].timeline ?? []), // Provide your posts data
        ),
      ),
      bottomNavigationBar: Bottombar(),
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
  // final post;
  const ProfileView({Key? key, UserTimelineModel})
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
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    image: DecorationImage(
                      image: AssetImage('assets/page-1/images/aa.jpg'),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                Column(
                  children: [
                    Text(
                      '30',
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
                      '10K',
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
                    text: 'Amit Kumar',
                    style: const TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                  TextSpan(
                    text: '\nFlutter Demo\nFlutter web\nFlutter Linux',
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
  final List<ArticleModel> posts;

  const ProfilePostScreen({Key? key, required this.posts}) : super(key: key);

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

    widget.posts.forEach((e) {
      if (currentUser != null && e.likes != null) {
        e?.likes?.any((like) => like.user!.id == currentUser.id) ?? false;
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

  @override
  Widget build(BuildContext context) {
print('here here');

    print(widget.posts);

    if (widget.posts == null) {
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
print('posts $post');

    return Container(
      margin: const EdgeInsets.symmetric(vertical: 5.0),
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      color: Color(0xFFFFFFFF),
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
                      Uri.parse(post.media?[0].path ?? '').toString(),
                    ),
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
              decoration: BoxDecoration(
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
