import 'package:flutter/material.dart';
import 'package:myapp/models/user_model.dart';
import 'package:myapp/page-1/ProfileScreen.dart';
import 'package:myapp/page-1/feeds/postScreen.dart';
import 'package:myapp/services/user_service.dart';
import 'package:myapp/widgets/AddFriends.dart';
import 'package:page_transition/page_transition.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage>
    with AutomaticKeepAliveClientMixin {
  final GraphQLService userService = GraphQLService();
  List<UserModel> _allUsers = [];
  List<UserModel> _foundUsers = [];
  String enteredKeyword = '';
  @override
  initState() {
    _load();
    _foundUsers = _allUsers;
    super.initState();
  }

  Future<void> _load() async {
    final allUsers = await userService.getUsers(search: enteredKeyword);
    setState(() {
      _allUsers = allUsers;
      _foundUsers = allUsers;
    });
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
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextFormField(
              onChanged: (value) => _runFilter(value),
              decoration: InputDecoration(
                contentPadding:
                    const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
                hintText: "Search For your Old Mates",
                hintStyle: const TextStyle(color: Colors.grey),
                suffixIcon: const Icon(
                  Icons.search,
                  color: Color.fromARGB(255, 244, 209, 54),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: const BorderSide(
                    color: Color.fromARGB(80, 167, 135, 135),
                  ),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: const BorderSide(
                    color: Color.fromARGB(80, 167, 135, 135),
                  ),
                ),
              ),
            ),
            const Padding(
              padding: EdgeInsets.fromLTRB(8, 20, 8, 8),
              child: Text(
                'Recent friends',
                style: TextStyle(
                  color: Color.fromARGB(255, 167, 135, 135),
                  decoration: TextDecoration.none,
                  fontFamily: 'PermanentMarker-Regular',
                  fontWeight: FontWeight.bold,
                  fontSize: 14,
                ),
              ),
            ),
            const SizedBox(
              height: 8,
            ),
            Expanded(
              child: _foundUsers.isNotEmpty
                  ? ListView.builder(
                      itemCount: _foundUsers.length,
                      itemBuilder: (context, index) => GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            PageTransition(
                              type: PageTransitionType.scale,
                              alignment: Alignment.bottomCenter,
                              child: ProfileScreen(
                                user: _foundUsers[index],
                              ),
                            ),
                          );
                        },
                        child: Card(
                          color: const Color.fromARGB(0, 167, 135, 135),
                          elevation: 0,
                          margin: const EdgeInsets.symmetric(vertical: 1),
                          child: ListTile(
                            leading: Avatar(user: _foundUsers[index]),
                            title: SingleChildScrollView(
                              scrollDirection: Axis.horizontal,
                              child: Text(
                                _foundUsers[index].fullName,
                                style: const TextStyle(
                                    color: Color.fromARGB(255, 167, 135, 135),
                                    fontFamily: 'Poppins',
                                    fontSize: 16),
                              ),
                            ),
                          ),
                        ),
                      ),
                    )
                  : const Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Text(
                        'No results found. Please try with a different search.',
                        style: TextStyle(
                          color: Color.fromARGB(255, 167, 135, 135),
                          decoration: TextDecoration.none,
                          fontFamily: 'PermanentMarker-Regular',
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                        ),
                      ),
                    ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
}
