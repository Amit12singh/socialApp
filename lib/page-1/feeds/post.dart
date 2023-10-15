import 'package:flutter/material.dart';
import 'package:myapp/models/article_model.dart';
import 'package:myapp/services/article_service.dart';
import 'package:myapp/utilities/localstorage.dart';

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
  final PostService postService = PostService();
  final HandleToken useService = HandleToken();
  bool isExpanded = false;

  List<ArticleModel>? posts;

  var _user = null;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _loadData();
  }

  void _loadData() async {
    // Fetch the user information
    final user = await useService.getUser();

    // Fetch the list of articles (posts)
    final List<ArticleModel> _posts = await postService.getArticles();

    setState(() {
      _user = user;
      posts = _posts;
    });
    print("here screen $_posts");
  }


  @override
  Widget build(BuildContext context) {
    if (posts == null) {
      return const Center(
        child: CircularProgressIndicator(),
      );
    } else {
      return ListView.builder(
        itemCount: posts?.length ?? 0, // Number of posts
        itemBuilder: (context, index) {
          return buildPostCard(posts![index]);
        },
      );
    }
  }

  Widget buildPostCard(ArticleModel post) {
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
            post.owner!.email ?? '', // Use the username from the Post object
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
                    : post.title, // Use the content from the Post object
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
        GridView.builder(
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2, // Adjust the number of columns as needed
          ),
          itemBuilder: (context, index) {
            if (index < post.media!.length) {
              return Container(
                decoration: BoxDecoration(
                  image: DecorationImage(
                    fit: BoxFit.cover,
                    image: NetworkImage(post.media?[index].path ?? ''),
                  ),
                ),
              );
            } else {
              // Return a placeholder or empty container
              return Container();
            }
          },
          itemCount: post.media!.length,
        ),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              GestureDetector(
                  onTap: () {
                    setState(() {
                      // post.isLiked =
                      //     !post.isLiked; // Toggle isLiked for this post
                    });
                  },
                  child: Icon(
                    post.likes != null &&
                            post.likes!.isNotEmpty &&
                            post.likes!.any((e) => e.id == _user.id)
                        ? Icons.favorite_rounded
                        : Icons.favorite_border_rounded,
                    color: post.isLiked ? Colors.red : Colors.black,
                    size: 35,
                  )),
              Text('1K likes'),
            ],
          ),
        ),
      ],
    );
  }
}
