import 'package:flutter/material.dart';

class Post {
  final String username;
  final String content;
  final String imageUrl; // URL to the user's profile image
  bool isLiked; // Add isLiked status for each post

  Post(this.username, this.content, this.imageUrl, this.isLiked);
}

class PostScreen extends StatefulWidget {
  const PostScreen({Key? key}) : super(key: key);

  @override
  _PostScreenState createState() => _PostScreenState();
}

class _PostScreenState extends State<PostScreen> {
  bool isExpanded = false;

  List<Post> posts = [
    Post(
      'Old Nabhaites',
      'Team ONA called on the New Governor of Punjab, Honorable Shri Banwari Lal Purohit, and welcomed ...',
      'assets/page-1/images/rectangle-688.png',
      false, // Set initial isLiked status for the first post
    ),
    Post(
      'Old Nabhaites',
      'The second Induction Ceremony was organized on 01 March 2021 for the students passing out in ...',
      'assets/page-1/images/rectangle-693-bg.png',
      false, // Set initial isLiked status for the second post
    ),
    // Add more posts here...
  ];

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: posts.length, // Number of posts
      itemBuilder: (context, index) {
        return buildPostCard(posts[index]);
      },
    );
  }

  Widget buildPostCard(Post post) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ListTile(
          leading: Container(
            width: 50,
            height: 50,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(),
              image: DecorationImage(
                image: AssetImage('assets/page-1/images/ellipse-2-bg.png'),
                fit: BoxFit.cover,
              ),
            ),
          ),
          title: Text(
            post.username, // Use the username from the Post object
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          trailing: IconButton(
            icon: Icon(Icons.more_vert),
            onPressed: () {},
          ),
        ),
        Container(
          padding: EdgeInsets.all(16.0),
          child: Column(
            children: [
              Text(
                isExpanded
                    ? 'See less'
                    : post.content, // Use the content from the Post object
                textAlign: TextAlign.justify,
              ),
              Align(
                alignment: Alignment.centerRight,
                child: GestureDetector(
                  onTap: () {
                    setState(() {
                      isExpanded = !isExpanded;
                    });
                  },
                  child: Icon(
                    isExpanded ? Icons.expand_less : Icons.expand_more,
                    color: Colors.blue,
                  ),
                ),
              ),
            ],
          ),
        ),
        Container(
          height: 300,
          decoration: BoxDecoration(
            image: DecorationImage(
              fit: BoxFit.cover,
              image: AssetImage(
                  post.imageUrl), // Use the image URL from the Post object
            ),
          ),
        ),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              GestureDetector(
                onTap: () {
                  setState(() {
                    post.isLiked =
                        !post.isLiked; // Toggle isLiked for this post
                  });
                },
                child: Icon(
                  post.isLiked
                      ? Icons.favorite_rounded
                      : Icons.favorite_border_rounded,
                  color: post.isLiked ? Colors.red : Colors.black,
                  size: 35,
                ),
              ),
              Text('1K likes'),
            ],
          ),
        ),
      ],
    );
  }
}
