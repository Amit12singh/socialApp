class ProfilePicture {
  final String? id;
  final String mimeType;
  final String? path;
  final String type;
  final String name;

  ProfilePicture(
      {this.id,
      required this.mimeType,
      this.path,
      required this.name,
      required this.type});
}

class UserModel {
  final String? id;
  final String fullName;
  final String email;

  final ProfilePicture? profilePicture;
  final DateTime? createdAt;
  final DateTime? deletedAt;
  final DateTime? updatedAt;
  final String? password;

  UserModel({
    this.id,
    required this.fullName,
      required this.email,
      this.profilePicture,
      this.deletedAt,
      this.updatedAt,
      this.createdAt,
      this.password
  });

  static UserModel fromMap({required Map map}) {
    return UserModel(
      id: map['id'],
      email: map['email'],
      fullName: map['fullName'],
      profilePicture: ProfilePicture(
          id: map['profilePicture']['id'],
          mimeType: map['profilePicture']['mimeType'],
          path: map['profilePicture']['path'],
          name: map['profilePicture']['name'],
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
