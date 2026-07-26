import 'package:cleanarch/core/Error/exceptions.dart';
import 'package:cleanarch/features/auth/data/models/auth_response_model.dart';
import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

abstract class RemoteAuthDatasources {
  Future<AuthResponseModel> logInUser({
    required String username,
    required String password,
  });
  Future<AuthResponseModel> signUpUser({
    required String username,
    required String email,
    required String password,
  });
  Future<AuthResponseModel> getOAuthUserData();
  Future<bool> googleLogin();
  Future<void> signOutUser();
  Future<void> resetPassword(String email);
  Future<void> updatePassword(String password);
}

class RemoteAuthDatasourcesImpl implements RemoteAuthDatasources {
  final SupabaseClient client;

  @override
  Future<AuthResponseModel> getOAuthUserData() async {
    debugPrint(
      "============================================IN Oauth==============================================",
    );
    final session = client.auth.currentSession;
    final user = client.auth.currentUser;

    if (user == null || session == null) {
      throw InvalidUserException();
    }

    final authuser = await client
        .from('users')
        .select()
        .eq('id', user.id)
        .single();
    return AuthResponseModel.fromJson(authuser, session);
  }

  RemoteAuthDatasourcesImpl({required this.client});
  @override
  Future<bool> googleLogin() async {
    return await client.auth.signInWithOAuth(
      OAuthProvider.google,
      redirectTo: "my-social-app://login-callback",
      queryParams: {'prompt': 'select_account'},
    );
  }

  @override
  Future<AuthResponseModel> logInUser({
    required String username,
    required String password,
  }) async {
    final response = await client.auth.signInWithPassword(
      email: username,
      password: password,
    );

    if (response.user != null && response.session != null) {
      final authresponse = await client
          .from('users')
          .select()
          .eq('id', response.user!.id)
          .single();
      return AuthResponseModel.fromJson(authresponse, response.session!);
    } else {
      throw InvalidUserException();
    }
  }

  @override
  Future<AuthResponseModel> signUpUser({
    required String username,
    required String email,
    required String password,
  }) async {
    try {
      final response = await client.auth.signUp(
        email: email,
        password: password,
        data: {"username": username},
        emailRedirectTo: "my-social-app://login-callback",
      );

      return AuthResponseModel.fromSupabase(response.user!, response.session);
      // );
    } catch (e) {
      debugPrint(e.toString());
      throw ServerException();
    }
  }

  @override
  Future<void> signOutUser() async {
    return await client.auth.signOut();
  }

  @override
  Future<void> resetPassword(String email) async {
    try {
      await client.auth.resetPasswordForEmail(
        email,
        redirectTo: "my-social-app://login-callback",
      );
    } catch (e) {
      debugPrint(e.toString());
      throw ServerException();
    }
  }

  @override
  Future<void> updatePassword(String password) async {
    try {
      await client.auth.updateUser(UserAttributes(password: password));
    } catch (e) {
      debugPrint(e.toString());
      throw ServerException();
    }
  }
}
