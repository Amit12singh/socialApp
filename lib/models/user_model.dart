import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';
import 'dart:io';

class ProfilePicture {
  final String? id;
  final String? mimeType;
  final String? path;
  final String? type;
  final String? name;

  ProfilePicture({this.id, this.mimeType, this.path, this.name, this.type});

  static ProfilePicture fromMap({required Map<String, dynamic> map}) {
    return ProfilePicture(
      id: map['id'] as String?,
      mimeType: map['mimeType'] as String,
      name: map['name'] as String,
      type: map['type'] as String,
      path: map['path'] as String?,
    );
  }

  Future<List<http.MultipartFile>> convertMediaListToMultipart(
      List mediaList) async {
    final List<http.MultipartFile> multipartList = [];

    for (final media in mediaList) {
      final http.MultipartFile multipartFile = await convertToMultipart(media);
      multipartList.add(multipartFile);
    }

    return multipartList;
  }

  Future<http.MultipartFile> convertToMultipart(media) async {
    // The existing convertToMultipart function you provided
    final file = File(media.path);
    final byteData = await file.readAsBytes();

    return http.MultipartFile.fromBytes(
      'photos[]', // Use 'photos[]' to indicate it's an array of files
      byteData,
      filename: '${DateTime.now().second}.jpg',
      contentType: MediaType('image', 'jpg'),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'mimeType': mimeType,
      'path': path,
      'name': name,
      'type': type,
    };
  }

  // Deserialization from JSON
  factory ProfilePicture.fromJson(Map<String, dynamic> map) {
    return ProfilePicture(
      id: map['id'] as String?,
      mimeType: map['mimeType'] as String?,
      name: map['name'] as String?,
      type: map['type'] as String?,
      path: map['path'] as String?,
    );
  }
}

class UserModel {
  final String? id;
  final String fullName;
  final String email;
  final String? house;
  final String? houseNumber;
  final String? phoneNumber;
  final String? passedOutYear;
  final String? currentCity;
  final String? profession;
  final ProfilePicture? profilePicture;
  final DateTime? createdAt;
  final DateTime? deletedAt;
  final DateTime? updatedAt;


  UserModel(
      {this.id,
      required this.fullName,
      required this.email,
      this.profilePicture,
      this.deletedAt,
      this.updatedAt,
    this.createdAt,
    this.currentCity,
    this.house,
    this.houseNumber,
    this.passedOutYear,
    this.phoneNumber,
    this.profession,
  });



  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'fullName': fullName,
      'email': email,
      'profilePicture': profilePicture?.toJson(),
      'passedOutYear': passedOutYear,
      'createdAt': createdAt?.toIso8601String(),
      'deletedAt': deletedAt?.toIso8601String(),
      'updatedAt': updatedAt?.toIso8601String(),
    };
  }

  factory UserModel.fromJson(Map<String, dynamic> map) {
    return UserModel(
      id: map['id'],
      email: map['email'],
      fullName: map['fullName'],
      phoneNumber: map['phoneNumber'],
      currentCity: map['currentCity'],
      house: map['house'],
      houseNumber: map['houseNumber'],
      passedOutYear: map['yearPassedOut'] ?? map['passedOutYear'],
             
      profession: map['profession'],
      profilePicture: map['profileImage'] != null
          ? ProfilePicture.fromJson(map['profileImage'])
          : map['profilePicture'] != null
              ? ProfilePicture.fromJson(map['profilePicture'])
              : null,
      createdAt:
          map['createdAt'] != null ? DateTime.parse(map['createdAt']) : null,
      deletedAt:
          map['deletedAt'] != null ? DateTime.parse(map['deletedAt']) : null,
      updatedAt:
          map['updatedAt'] != null ? DateTime.parse(map['updatedAt']) : null,
     
    );
  }
}
