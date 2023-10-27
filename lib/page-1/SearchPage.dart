import 'package:flutter/material.dart';
import 'package:myapp/models/user_model.dart';
import 'package:myapp/page-1/ProfileScreen.dart';
import 'package:myapp/page-1/feeds/bottombar.dart';
import 'package:myapp/page-1/feeds/post.dart';
import 'package:myapp/services/user_service.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  final GraphQLService userService = GraphQLService();

  List<UserModel> _allUsers = [];

  List<UserModel> _foundUsers = [];
  String enteredKeyword = '';
  @override
  initState() {
    // at the beginning, all users are shown
    _load();
    _foundUsers = _allUsers;
    super.initState();
  }

  _load() async {
    final allUsers = await userService.getUsers(search: enteredKeyword);

    setState(() {
      _allUsers = allUsers;
      _foundUsers = allUsers;
    });
    return allUsers;
  }

  void _runFilter(String enteredKeyword) {
    List<UserModel> results = [];
    if (enteredKeyword.isEmpty) {
      results = _allUsers;
    } else {
      results = _allUsers
          .where((user) => user.fullName
              .toLowerCase()
              .contains(enteredKeyword.toLowerCase()))
          .toList();
    }

    setState(() {
      enteredKeyword = enteredKeyword;
      _foundUsers = results;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
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
            color: Color.fromARGB(255, 167, 135, 135),
            decoration: TextDecoration.none,
            fontFamily: 'PermanentMarker-Regular',
            fontWeight: FontWeight.bold,
            fontSize: 25,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          children: [
            // const Text(
            //   'Search For your Old Mates',
            //   textAlign: TextAlign.left,
            //   style: TextStyle(
            //     color: Color.fromARGB(255, 167, 135, 135),
            //     decoration: TextDecoration.none,
            //     fontFamily: 'PermanentMarker-Regular',
            //     fontWeight: FontWeight.bold,
            //     fontSize: 20,
            //   ),
            // ),
            // const Divider(
            //   color: Color.fromARGB(40, 167, 135, 135),
            //   height: 20,
            //   thickness: 3,
            // ),
            TextFormField(
              onChanged: (value) => _runFilter(value),
              decoration: InputDecoration(
                contentPadding:
                    const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
                hintText: "Search For your Old Mates",
                hintStyle: TextStyle(color: Colors.grey),
                suffixIcon: const Icon(
                  Icons.search,
                  color: Color.fromARGB(255, 244, 209, 54),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: const BorderSide(
                    color: Color.fromARGB(80, 167, 135, 135),
                  ), // Color when not focused
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: const BorderSide(
                    color:
                        Color.fromARGB(80, 167, 135, 135), // Color when focused
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Expanded(
              child: _foundUsers.isNotEmpty
                  ? ListView.builder(
                      itemCount: _foundUsers.length,
                      itemBuilder: (context, index) => GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => ProfileScreen(
                                user: _foundUsers[index],
                              ),
                            ),
                          );
                        },
                        child: Card(
                          color: Color.fromARGB(0, 167, 135, 135),
                          elevation: 0,
                          margin: const EdgeInsets.symmetric(vertical: 1),
                          child: ListTile(
                            leading: Avatar(user: _foundUsers[index]),
                            title: Text(
                              _foundUsers[index].fullName,
                              style: TextStyle(
                                  color: Color.fromARGB(255, 167, 135, 135),
                                  fontFamily: 'Poppins',
                                  fontSize: 16),
                            ),
                          ),
                        ),
                      ),
                    )
                  : const Text(
                      'No results found. Please try with a different search.',
                      style: TextStyle(fontSize: 24),
                    ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: Bottombar(),
    );
  }
}
