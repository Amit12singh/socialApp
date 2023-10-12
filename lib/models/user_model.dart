class ProfilePicture {
  final String id;
  final String mimeType;
  final String path;
  final String type;

  ProfilePicture(
      {required this.id,
      required this.mimeType,
      required this.path,
      required this.type});
}

class UserModel {
  final String? id;
  final String fullName;
  final ProfilePicture profilePicture;
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
      profilePicture: ProfilePicture(
          id: map['profilePicture']['id'],
          mimeType: map['profilePicture']['mimeType'],
          path: map['profilePicture']['path'],
          type: map['profilePicture']['type']),
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
