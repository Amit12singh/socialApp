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
    // UserModel? userList;
    List<UserModel> likes = [];
    print(map['owner']);
    // if (map['media'] != null) {
    //   mediaList = (map['media'])
    //       .map((mediaData) => ProfilePicture.fromJson(mediaData))
    //       .toList();
    // }
    // if (map['owner'] != null) {
    //   userList = UserModel.fromMap(map: map['owner']);
    // }
    print('article model media $mediaList');

   

    return ArticleModel(
      id: map['id'],
      title: map['title'],
      media: mediaList,
      // owner: userList,
      // likes: likes,
      createdAt: DateTime.parse(map['createdAt']),
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
      // likes: json['likes'],
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
    


  
  
  

