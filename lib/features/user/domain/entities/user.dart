class User {
  final String id;
  final String username;
  final String email;
  final String? name;
  final String? bio;
  final String? gender;
  final String? imageUrl;
  final String? backgroundUrl;
  final int followersCount;
  final int followingCount;

  const User({
    required this.id,
    required this.username,
    required this.email,
    this.name,
    this.bio,
    this.gender,
    this.imageUrl,
    this.backgroundUrl,
    this.followersCount = 0,
    this.followingCount = 0,
  });
}
