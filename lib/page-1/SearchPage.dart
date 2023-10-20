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

    final allUsers = await userService.getUsers(search: enteredKeyword ?? ' ');

    setState(() {
      _allUsers = allUsers;
      _foundUsers = allUsers;
    });
    return allUsers;
  }

  // This function is called whenever the text field changes
  void _runFilter(String enteredKeyword) {
    List<UserModel> results = [];
    if (enteredKeyword.isEmpty) {
      // if the search field is empty or only contains white-space, we'll display all users
      results = _allUsers;
    } else {
      results = _allUsers
          .where((user) =>
              user.fullName
              .toLowerCase()
              .contains(enteredKeyword.toLowerCase()))
          .toList();
      // we use the toLowerCase() method to make it case-insensitive
    }

    // Refresh the UI
    setState(() {
      enteredKeyword = enteredKeyword;
      _foundUsers = results;
    });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text("Friends List"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          children: [
            TextFormField(
              onChanged: (value) => _runFilter(value),
              decoration: InputDecoration(
                contentPadding:
                    const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
                hintText: "Search",
                suffixIcon: const Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20),
                  borderSide: BorderSide(),
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
                          // Navigate to the individual ProfileScreen
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
                          elevation: 1,
                          margin: const EdgeInsets.symmetric(vertical: 2),
                          child: ListTile(
                            leading: Avatar(user: _foundUsers[index]),
                            title: Text(_foundUsers[index].fullName),
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
