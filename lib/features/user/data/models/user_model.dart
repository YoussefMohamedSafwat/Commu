import 'package:cleanarch/features/user/domain/entities/user.dart';

class UserModel extends User {
  const UserModel({
    required super.id,
    required super.username,
    required super.email,
    super.name,
    super.bio,
    super.gender,
    super.imageUrl,
    super.backgroundUrl,
    super.followersCount,
    super.followingCount,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'],
      username: json['username'],
      email: json['email'] ?? "",
      name: json['name'],
      bio: json['bio'],
      gender: json['gender'],
      imageUrl: json['image_url'],
      backgroundUrl: json['background_url'],
      followersCount: json['followers_count'] ?? 0,
      followingCount: json['following_count'] ?? 0,
    );
  }
  Map<String, dynamic> toJson() => {
    'id': id,
    'username': username,
    'email': email,
    'name': name,
    'bio': bio,
    'gender': gender,
    'image_url': imageUrl,
    'background_url': backgroundUrl,
    'followers_count': followersCount,
    'following_count': followingCount,
  };
}
