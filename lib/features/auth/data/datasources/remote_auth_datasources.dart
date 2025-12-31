import 'dart:convert';
import 'package:cleanarch/core/Error/exceptions.dart';
import 'package:cleanarch/core/constants/urls.dart';
import 'package:cleanarch/features/auth/data/models/auth_response_model.dart';
import 'package:http/http.dart' as http;

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
}

class RemoteAuthDatasourcesImpl implements RemoteAuthDatasources {
  final http.Client client;

  RemoteAuthDatasourcesImpl({required this.client});
  @override
  Future<AuthResponseModel> logInUser({
    required String username,
    required String password,
  }) async {
    final body = {"username": username, "password": password};

    final response = await client.post(
      Uri.parse("$dummyJsonUrl/auth/login"),
      body: body,
    );

    if (response.statusCode == 200) {
      final jsondata = jsonDecode(response.body);
      return AuthResponseModel.fromJson(jsondata);
    } else {
      final data = jsonDecode(response.body);

      if (data != null) {
        throw InvalidUserException();
      }

      throw ServerException();
    }
  }

  @override
  Future<AuthResponseModel> signUpUser({
    required String username,
    required String email,
    required String password,
  }) async {
    final Map<String, String> body = {
      "username": username,
      "email": email,
      "password": password,
    };

    final response = await client.post(
      Uri.parse("$dummyJsonUrl/users/add"),
      body: body,
    );

    if (response.statusCode == 201) {
      final jsondata = jsonDecode(response.body);

      return AuthResponseModel.fromJson(jsondata);
    }

    throw ServerException();
  }
}
