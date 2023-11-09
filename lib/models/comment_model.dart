import 'package:myapp/models/user_model.dart';

class CommentModel {
  final String id;
  final UserModel? user;
  final String comment;

  CommentModel({required this.id, required this.user, required this.comment});

  factory CommentModel.fromJson(Map json) {
    return CommentModel(
        id: json['id'],
        user: UserModel.fromJson(json['user']),
        comment: json['comment']);
  }
}
