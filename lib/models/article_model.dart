
import 'package:myapp/models/comment_model.dart';
import 'package:myapp/models/like_model.dart';
import 'package:myapp/models/user_model.dart';
import 'package:myapp/utilities/localstorage.dart';

class ArticleModel {
  final String? id;
  final String title;
  final List<ProfilePicture>? media;
  final DateTime createdAt;
  final DateTime? deletedAt;
  final DateTime? updatedAt;
  final UserModel? owner;
  final List<Like>? likes;
  final List<CommentModel>? comments;
  int totalLikes;

  ArticleModel({
    this.id,
    required this.title,
    this.media,
    this.deletedAt,
    this.updatedAt,
    required this.createdAt,
    this.likes,
    this.comments,
    this.owner,
  }) : totalLikes = likes?.length ?? 0;

  updateLikes(int like) {
    totalLikes = like;
  }

  Future<UserModel?> currentUser = HandleToken().getUser();

  static ArticleModel fromMap({required map}) {
    List<ProfilePicture> mediaList = [];
    // UserModel? userList;
    // List<Like> likes = [];

    return ArticleModel(
      id: map['id'],
      title: map['title'],
      media: mediaList,
      createdAt:
          DateTime.fromMillisecondsSinceEpoch(int.parse(map['createdAt'])),
      deletedAt:
          map['deletedAt'] != null ? DateTime.parse(map['deletedAt']) : null,
    );
  }

  factory ArticleModel.fromJson(Map json) {
    return ArticleModel(
      id: json['id'],
      likes: (json['likes'] != null)
          ? (json['likes'] as List)
              .map((likedUser) => Like.fromJson(likedUser))
              .toList()
          : <Like>[],
      comments: (json['comments'] != null)
          ? (json['comments'] as List)
              .map((comment) => CommentModel.fromJson(comment))
              .toList()
          : <CommentModel>[],
      owner: UserModel.fromJson(json['owner']),
      title: json['title'],
      createdAt: DateTime.parse(json['createdAt']),
      deletedAt:
          json['deletedAt'] != null ? DateTime.parse(json['deletedAt']) : null,
      media: (json['media'] as List)
          .map((mediaJson) => ProfilePicture.fromJson(mediaJson))
          .toList(),
    );
  }
}
