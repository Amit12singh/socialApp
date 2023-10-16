import 'package:myapp/models/like_model.dart';
import 'package:myapp/models/user_model.dart';
import 'package:myapp/utilities/localstorage.dart';

class ArticleModel {
  final String? id;
  final String title;
  final List<ProfilePicture>? media;
  final DateTime? createdAt;
  final DateTime? deletedAt;
  final DateTime? updatedAt;
  final UserModel? owner;
  final List<Like>? likes;
  int totalLikes;

  ArticleModel({
    this.id,
    required this.title,
    this.media,
    this.deletedAt,
    this.updatedAt,
    this.createdAt,
    this.likes,
    this.owner,
  }) : totalLikes = likes?.length ?? 0;

  Future<UserModel?> currentUser = HandleToken().getUser();
  dynamic() => print('currentUser $currentUser');

  // ignore: unnecessary_null_comparison
  // bool? get isLiked {
  //   if (currentUser != null && likes != null) {
  //     return likes?.any((like) => like.user?.id == currentUser.id);
  //   }
  //   return false;
  // }
  static ArticleModel fromMap({required map}) {
    print('article model $map');
    List<ProfilePicture> mediaList = [];
    // UserModel? userList;
    List<Like> likes = [];

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
    print('article modal json $json');
    return ArticleModel(
      id: json['id'],
      likes: (json['likes'] != null)
          ? (json['likes'] as List)
              .map((likedUser) => Like.fromJson(likedUser))
              .toList()
          : <Like>[],
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
