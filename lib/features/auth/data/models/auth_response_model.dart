import 'package:cleanarch/features/auth/data/models/auth_user_model.dart';
import 'package:cleanarch/features/user/data/models/user_model.dart';
import 'package:cleanarch/features/auth/domain/entities/auth_response.dart';
import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart' as sb;

class AuthResponseModel extends AuthResponse {
  AuthResponseModel({required super.user, required super.auth});

  factory AuthResponseModel.fromJson(
    Map<String, dynamic> user,
    sb.Session sbSession,
  ) {
    return AuthResponseModel(
      user: UserModel.fromJson(user),
      auth: AuthUserModel.fromJson(sbSession),
    );
  }
  factory AuthResponseModel.fromSupabase(
    sb.User? sbUser,
    sb.Session? sbSession,
  ) {
    if (sbUser == null) {
      return AuthResponseModel(
        user: const UserModel(id: "", username: '', email: ''),
        auth: null,
      );
    }

    final metadata = sbUser.userMetadata ?? {};

    final userModel = UserModel(
      id: sbUser.id,

      username:
          metadata['username'] ?? sbUser.email?.split('@').first ?? 'unknown',
      email: sbUser.email ?? '',
      name: metadata['first_name'] ?? '',
      bio: metadata['bio'] ?? '',
      imageUrl: metadata['avatar_url'] ?? '',
    );

    AuthUserModel? authUserModel;
    if (sbSession != null) {
      authUserModel = AuthUserModel(
        token: sbSession.accessToken,
        refreshToken: sbSession.refreshToken ?? '',
      );
    }

    debugPrint(
      "user after parsing : id ${userModel.id} username : ${userModel.username}, imageurl : ${userModel.imageUrl}",
    );
    debugPrint(" session after parsing : $authUserModel");
    return AuthResponseModel(user: userModel, auth: authUserModel);
  }
}
