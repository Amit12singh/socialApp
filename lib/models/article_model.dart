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

  get isLiked => null;

  static ArticleModel fromMap({required map}) {
    print('article model $map');
    List<ProfilePicture> mediaList = [];
    // UserModel? userList;
    List<UserModel> likes = [];

   

   

    return ArticleModel(
      id: map['id'],
      title: map['title'],
      media: mediaList,
      createdAt:
          DateTime.fromMillisecondsSinceEpoch(int.parse(map['createdAt'])),
      deletedAt:
          map['deletedAt'] != null ? DateTime.parse(map['deletedAt']) : null,
      // updatedAt: DateTime.fromMillisecondsSinceEpoch(
      //   int.parse(map['createdAt'] ?? ''),
      // ),
    );
  }

  factory ArticleModel.fromJson(Map<String, dynamic> json) {
    return ArticleModel(
      id: json['id'],
      likes: (json['likes'] as List)
          .map((likedUser) => UserModel.fromJson(likedUser))
          .toList(),
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
    


  
  
  

