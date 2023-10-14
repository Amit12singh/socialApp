import 'package:flutter/material.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key});

  @override
  State<ProfileScreen> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<ProfileScreen> {
  List<String> posts = [
    'assets/page-1/images/rectangle-688.png',
    'assets/page-1/images/rectangle-693-bg.png',
    'assets/page-1/images/rectangle-688.png',
    'assets/page-1/images/rectangle-693-bg.png',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: DefaultTabController(
        length: 1,
        child: NestedScrollView(
          physics: const NeverScrollableScrollPhysics(),
          headerSliverBuilder: (context, isScrolled) {
            return [
              SliverAppBar(
                backgroundColor: Colors.white,
                collapsedHeight: 250,
                expandedHeight: 250,
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
          body: TabBarView(
            children: [
              GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 1,
                  crossAxisSpacing: 1.0,
                  mainAxisSpacing: 1.0,
                ),
                itemCount: posts.length,
                itemBuilder: (context, index) {
                  return GridTile(
                    child: Image.asset(posts[index]),
                    footer: Container(
                      color: Colors.white,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          'Text for Photo $index',
                          style: const TextStyle(fontSize: 16),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ],
          ),
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

class ProfileView extends StatefulWidget {
  const ProfileView({Key? key});

  @override
  State<ProfileView> createState() => _ProfileViewState();
}

class _ProfileViewState extends State<ProfileView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
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
      ),
    );
  }
}
