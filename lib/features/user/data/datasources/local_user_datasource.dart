import 'dart:convert';
import 'package:cleanarch/core/Error/exceptions.dart';
import 'package:cleanarch/features/user/data/models/user_model.dart';
import 'package:dartz/dartz.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract class LocalUserDatasource {
  Future<Unit> cacheUser({required UserModel user});
  Future<UserModel> getCachedUser();
  Future<Unit> clearCachedUser();
}

const cachedUser = "CACHED_USER";

class LocalUserDataSourceImpl implements LocalUserDatasource {
  final SharedPreferences sharedPreferences;

  LocalUserDataSourceImpl({required this.sharedPreferences});
  @override
  Future<Unit> cacheUser({required UserModel user}) async {
    final userJson = jsonEncode(user.toJson());
    await sharedPreferences.setString(cachedUser, userJson);

    return Future.value(unit);
  }

  @override
  Future<UserModel> getCachedUser() {
    final userJson = sharedPreferences.getString(cachedUser);

    if (userJson != null) {
      return Future.value(UserModel.fromJson(jsonDecode(userJson)));
    }
    throw EmptyCacheException();
  }

  @override
  Future<Unit> clearCachedUser() async {
     await sharedPreferences.remove(cachedUser);
      return Future.value(unit);
  }
}
