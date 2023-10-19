import 'package:flutter/material.dart';
import 'package:myapp/models/pagination_model.dart';
import 'package:myapp/models/user_model.dart';
import 'package:myapp/services/user_service.dart';
import 'package:shimmer/shimmer.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({Key? key}) : super(key: key);

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  GraphQLService userService = GraphQLService();
  TextEditingController searchController = TextEditingController();
List<UserModel>? _data;

  @override
  void initState() {
    super.initState();
    _searchUser();
  }

  void _searchUser() async {
    List<UserModel> data =
        await userService.getUsers(data: {"search": searchController.text});
    print('data $data');

    setState(() {
      _data = data;
    });
  }





  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.blue,
          title: const Text('Friends List')),
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextFormField(
                controller: searchController,
                onEditingComplete: () async {
                  // Handle the "Done" key press here
                  print("Done key pressed");
                  // You can perform any action or submit the form.
                  print(searchController.text);
                  _searchUser();

                  // You can perform any action or submit the form.
                },
                onChanged: (value) {
                  setState(() {});

                },
                decoration: InputDecoration(
                  contentPadding: const EdgeInsets.symmetric(horizontal: 20),
                  hintText: 'Search your friends name',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(50.0),
                  ),
                ),
              ),
            ),
            Expanded(
              child: FutureBuilder<List>(
                future: userService
                    .getUsers(data: {"search": searchController.text}),
                builder: (context, snapshot) {
                  if (!snapshot.hasData) {
                    return ListView.builder(
                      itemCount: 4,
                      itemBuilder: (context, index) {
                        return Shimmer.fromColors(
                          baseColor: Colors.grey.shade700,
                          highlightColor: Colors.grey.shade100,
                          child: Column(
                            children: [
                              ListTile(
                                title: Container(
                                  height: 10,
                                  width: 80,
                                  color: Colors.blue,
                                ),
                                subtitle: Container(
                                  height: 10,
                                  width: 80,
                                  color: Colors.blue,
                                ),
                                leading: Container(
                                  height: 10,
                                  width: 80,
                                  color: Colors.blue,
                                ),
                              )
                            ],
                          ),
                        );
                      },
                    );
                  } else {
                    return ListView.builder(
                      itemCount: _data!.length,
                      itemBuilder: (context, index) {
                        String name = _data![index].fullName;

                        if (searchController.text.isEmpty) {
                          return Column(
                            children: [
                              InkWell(
                                onTap: () {
                                  //profile
                                },
                                child: ListTile(
                                  title: Text(_data![index].fullName),
                                  leading: Image(
                                    height: 50,
                                    width: 50,
                                    image: NetworkImage(
                                      snapshot.data![index]['countryInfo']
                                          ['flag'],
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          );
                        } else if (name
                            .toLowerCase()
                            .contains(searchController.text.toLowerCase())) {
                          return Column(
                            children: [
                              InkWell(
                                onTap: () {
                                  //profile
                                },
                                child: ListTile(
                                  title: Text(snapshot.data![index]['Name']),
                                  leading: Image(
                                    height: 50,
                                    width: 50,
                                    image: NetworkImage(
                                      snapshot.data![index]['countryInfo']
                                          ['flag'],
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          );
                        } else {
                          return Container();
                        }
                      },
                    );
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
