import 'package:ppsona/models/user_model.dart';

class CommentModel {
  final String id;
  final UserModel user;
  final String comment;
  final DateTime createdAt;

  CommentModel(
      {required this.id,
      required this.user,
      required this.comment,
      required this.createdAt});

  factory CommentModel.fromJson(Map json) {
    return CommentModel(
      id: json['id'],
      user: UserModel.fromJson(json['user']),
      comment: json['comment'],
      createdAt: DateTime.parse(json['createdAt']),
    );
  }
}
