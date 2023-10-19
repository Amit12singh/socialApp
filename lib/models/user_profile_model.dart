import 'package:myapp/models/article_model.dart';
import 'package:myapp/models/user_model.dart';

class UserTimelineModel {
  UserModel profile;
  int totalLikes;
  int totalPosts;
  List<ArticleModel>? timeline;
  bool success;

  UserTimelineModel({
    required this.profile,
    required this.totalLikes,
    required this.totalPosts,
    this.timeline,
    required this.success,
  });

  factory UserTimelineModel.fromJson(Map<String, dynamic> json) {
    return UserTimelineModel(
      profile: UserModel.fromJson(json['profile']),
      totalLikes: json['totalLikes'] as int,
      totalPosts: json['totalPosts'] as int,
      timeline: (json['TimeLine'] as List<dynamic>?)
          ?.map((e) => ArticleModel.fromJson(e))
          .toList(),
      success: json['success'] as bool,
    );
  }
}
