import 'package:cleanarch/features/auth/domain/entities/auth_user.dart';
import 'package:supabase_flutter/supabase_flutter.dart' as sb;

class AuthUserModel extends AuthUser {
  AuthUserModel({required super.token, required super.refreshToken});

  factory AuthUserModel.fromJson(sb.Session sbSession) {
    return AuthUserModel(
      token: sbSession.accessToken,
      refreshToken: sbSession.refreshToken!,
    );
  }

  Map<String, dynamic> toJson() => {
    "accessToken": token,
    "refreshToken": refreshToken,
  };
}
