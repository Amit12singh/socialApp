import 'package:myapp/models/user_model.dart';

class Like {
  final String id;
  final UserModel? user;

  Like({required this.id, this.user});

  factory Like.fromJson(Map json) {
    print('here like model $json');
    return Like(
      id: json['id'],
      user: UserModel.fromJson(json['user']),
    );
  }
}
