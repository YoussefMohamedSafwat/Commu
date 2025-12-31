import 'package:cleanarch/features/auth/domain/entities/auth_user.dart';
import 'package:uuid/uuid.dart';

final uuid = Uuid();

class AuthUserModel extends AuthUser {
  AuthUserModel({required super.token, required super.refreshToken});

  factory AuthUserModel.fromJson(Map<String, dynamic> json) {
    return AuthUserModel(
      token: json["accessToken"] ?? uuid.v4(),
      refreshToken: json["refreshToken"] ?? uuid.v4(),
    );
  }

  Map<String, dynamic> toJson() => {
    "accessToken": token,
    "refreshToken": refreshToken,
  };
}
