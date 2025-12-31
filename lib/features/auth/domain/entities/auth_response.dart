import 'package:cleanarch/features/auth/domain/entities/auth_user.dart';
import 'package:cleanarch/features/user/domain/entities/user.dart';

class AuthResponse {
  final User user;
  final AuthUser? auth;

  AuthResponse({required this.user, this.auth});
}
