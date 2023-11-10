import 'package:flutter/material.dart';
import 'package:myapp/models/user_model.dart';

import 'package:myapp/page-1/feeds/homescreen.dart';
import 'package:myapp/services/user_service.dart';
import 'package:page_transition/page_transition.dart';

class BatchMatePage extends StatefulWidget {
  BatchMatePage({Key? key, this.user}) : super(key: key);

  UserModel? user;

  @override
  State<BatchMatePage> createState() => _BatchMatePageState();
}

class _BatchMatePageState extends State<BatchMatePage> {
  final GraphQLService userService = GraphQLService();

  List<UserModel> _allUsers = [];

  String enteredKeyword = '';

  @override
  void initState() {
    super.initState();
    _load();
  }

  Future<void> _load() async {
    print('batchmate');
    print('${widget.user?.passedOutYear}');
    final allUsers = await userService.getUsers(search: enteredKeyword);
    setState(() {
      _allUsers = allUsers;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar(context),
      body: listView(_allUsers),
      bottomNavigationBar: bottom(context),
    );
  }

  PreferredSizeWidget appBar(BuildContext context) {
    return AppBar(
      backgroundColor: const Color.fromARGB(255, 167, 135, 135),
      title: Text(
        'Your batch mates from ICSE year ${widget.user?.passedOutYear}',
        style: TextStyle(color: Colors.black),
      ),
      centerTitle: true,
      automaticallyImplyLeading: false,
    );
  }

  Widget listView(allUser) {
    return GridView.builder(
      gridDelegate:
          const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3),
      itemCount: allUser.length,
      itemBuilder: (context, index) {
        return ListViewItem(index, allUser);
      },
    );
  }

  Widget ListViewItem(int index, List<UserModel> allUser) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            width: 67,
            height: 67,
            padding: const EdgeInsets.all(4.0),
            decoration: const BoxDecoration(
                shape: BoxShape.circle,
                gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [Color(0xFF982282), Color(0xFFEEA863)])),
            child: Container(
              width: 65,
              height: 65,
              decoration: const BoxDecoration(
                color: Colors.white,
                shape: BoxShape.circle,
                
              ),
              child: Padding(
                padding: const EdgeInsets.all(4.0),
                child: Container(
                  width: 65,
                  height: 65,
                  decoration: BoxDecoration(
                    boxShadow: [
                      BoxShadow(
                        color: Colors.white,
                        spreadRadius: 1,
                      ),
                    ],
                    shape: BoxShape.circle,
                    image: allUser[index].profilePicture != null
                        ? DecorationImage(
                            fit: BoxFit.cover,
                            image: NetworkImage(
                              
                                allUser[index].profilePicture?.path ?? ''),
                          )
                        : const DecorationImage(
                            image: AssetImage(
                              'assets/page-1/images/ellipse-1-bg-Ztm.png',
                            ),
                          ),
                  ),
                ),
              ),
            ),
          ),
        ),
        const SizedBox(height: 4),
        Text(
          allUser[index].fullName,
          style: TextStyle(
            color: Colors.black,
            fontSize: 14,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }

  Widget bottom(BuildContext context) {
    return MaterialButton(
      onPressed: () async {
        await Navigator.of(context).pushReplacement(
          PageTransition(
            type: PageTransitionType.scale,
            alignment: Alignment.bottomCenter,
            child: FeedScreen(),
          ),
        );
      },
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      child: Container(
        width: 500,
        height: 55,
        decoration: BoxDecoration(
          color: Color.fromARGB(255, 167, 135, 135),
          borderRadius: BorderRadius.circular(16),
        ),
        child: const Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Let's get started",
              style: TextStyle(
                fontFamily: 'Poppins',
                fontSize: 18,
                fontWeight: FontWeight.w700,
                height: 1.5,
                color: const Color(0xffffffff),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
