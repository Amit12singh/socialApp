import 'package:myapp/models/user_model.dart';

class ArticleModel {
  final String? id;
  final String title;
  final List<ProfilePicture>? media;
  final DateTime createdAt;
  final DateTime deletedAt;
  final DateTime updatedAt;

  ArticleModel({
    this.id,
    required this.title,
    this.media,
    required this.deletedAt,
    required this.updatedAt,
    required this.createdAt,
  });

  static ArticleModel fromMap({required Map map}) {
    List<ProfilePicture> mediaList = (map['media'] as List)
        .map((mediaData) => ProfilePicture.fromMap(map: mediaData))
        .toList();

    return ArticleModel(
      id: map['id'],
      title: map['title'],
      media: mediaList,
      createdAt: DateTime.fromMillisecondsSinceEpoch(
        int.parse(map['createdAt']),
      ),
      deletedAt: DateTime.fromMillisecondsSinceEpoch(
        int.parse(map['createdAt']),
      ),
      updatedAt: DateTime.fromMillisecondsSinceEpoch(
        int.parse(map['createdAt']),
      ),
    );
  }
}
