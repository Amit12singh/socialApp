import 'package:flutter/material.dart';

class UserModel {
  final String? id;
  final String fullName;
  final String profilePicture;
  final DateTime createdAt;
  final DateTime deletedAt;
  final DateTime updatedAt;

  UserModel({
    this.id,
    required this.fullName,
    required this.profilePicture,
    required this.deletedAt,
    required this.updatedAt,
    required this.createdAt,
  });

  static UserModel fromMap({required Map map}) {
    return UserModel(
      id: map['id'],
      fullName: map['fullName'],
      profilePicture: map['profilePicture'],
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
