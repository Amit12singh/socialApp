import 'package:myapp/models/user_model.dart';

class ArticleModel {
  final String? id;
  final String title;
  final List<ProfilePicture>? media;
  final DateTime? createdAt;
  final DateTime? deletedAt;
  final DateTime? updatedAt;
  final UserModel? owner;
  final List<UserModel>? likes;

  ArticleModel({
    this.id,
    required this.title,
    this.media,
    this.deletedAt,
    this.updatedAt,
    this.createdAt,
    this.likes,
    this.owner,
  });

  get isLiked => null;

  static ArticleModel fromMap({required map}) {
    print('article model $map');
    List<ProfilePicture> mediaList = [];
    UserModel? userList;
    List<UserModel> likes = [];
    if (map['media'] != null) {
      mediaList = (map['media'] as List)
        .map((mediaData) => ProfilePicture.fromMap(map: mediaData))
        .toList();
    }
    if (map['owner'] != null) {
      userList = UserModel.fromMap(map: map['owner'] as Map);
    }
    print('article model media $mediaList');


    // if (map['likes'] != null && map['likes'].isNotEmpty) {
    //   likes = (map['likes'] as List<dynamic>)
    //     .map((usr) => UserModel.fromMap(map: usr))
    //     .toList();
    // }

    return ArticleModel(
      id: map['id'],
      title: map['title'],
      media: mediaList,
      owner: userList,
      likes: likes,
      createdAt: DateTime.fromMillisecondsSinceEpoch(
        int.parse(map['createdAt'] ?? ''),
      ),
      deletedAt: DateTime.fromMillisecondsSinceEpoch(
        int.parse(map['createdAt'] ?? ''),
      ),
      updatedAt: DateTime.fromMillisecondsSinceEpoch(
        int.parse(map['createdAt'] ?? ''),
      ),
    );
  }
}
