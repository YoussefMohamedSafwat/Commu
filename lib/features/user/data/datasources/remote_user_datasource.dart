import 'dart:convert';

import 'package:cleanarch/core/Error/exceptions.dart';
import 'package:cleanarch/core/constants/urls.dart';
import 'package:cleanarch/features/user/data/models/user_model.dart';
import 'package:http/http.dart' as http;

abstract class RemoteUserDatasource {
  Future<UserModel> getUserById(int userI);
}

class RemoteUserDatasourceImpl implements RemoteUserDatasource {
  final http.Client client;
  RemoteUserDatasourceImpl({required this.client});
  @override
  Future<UserModel> getUserById(int userId) async {
    final response = await client.get(Uri.parse("$dummyJsonUrl/users/$userId"));
    if (response.statusCode == 200) {
      final jsondata = jsonDecode(response.body);
      return UserModel.fromJson(jsondata);
    } else {
      throw ServerException();
    }
  }
}
