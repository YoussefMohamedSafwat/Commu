import 'dart:convert';

import 'package:cleanarch/core/Error/exceptions.dart';
import 'package:cleanarch/core/constants/urls.dart';
import 'package:cleanarch/features/user/data/models/user_model.dart';
import 'package:flutter/foundation.dart';
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
      debugPrint("loaded user correctly");
      final jsondata = jsonDecode(response.body);
      return UserModel.fromJson(jsondata);
    } else {
      debugPrint("response status code : ${response.statusCode.toString()}");
      debugPrint("response :${response.toString()}");
      throw ServerException();
    }
  }
}
