import 'package:flutter/material.dart';

class ArticleModel {
  final String? id;
  final String title;
  final String media;
  final DateTime createdAt;
  final DateTime deletedAt;
  final DateTime updatedAt;

  ArticleModel({
    this.id,
    required this.title,
    required this.media,
    required this.deletedAt,
    required this.updatedAt,
    required this.createdAt,
  });

  static ArticleModel fromMap({required Map map}) {
    return ArticleModel(
      id: map['id'],
      title: map['title'],
      media: map['media'],
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
