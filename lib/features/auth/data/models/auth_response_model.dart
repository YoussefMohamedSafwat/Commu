import 'package:cleanarch/features/auth/data/models/auth_user_model.dart';
import 'package:cleanarch/features/user/data/models/user_model.dart';
import 'package:cleanarch/features/auth/domain/entities/auth_response.dart';

class AuthResponseModel extends AuthResponse {
  AuthResponseModel({required super.user, required super.auth});

  factory AuthResponseModel.fromJson(Map<String, dynamic> json) {
    return AuthResponseModel(
      user: UserModel.fromJson(json),
      auth: AuthUserModel.fromJson(json),
    );
  }
}
