import 'dart:io';
import 'package:cleanarch/core/Error/exceptions.dart';
import 'package:cleanarch/features/user/data/models/user_model.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

abstract class RemoteUserDatasource {
  Future<UserModel> getUserById(String userId);
  Future<UserModel> updateUser({
    required String id,
    String? username,
    String? name,
    String? bio,
    String? profileAvatar,
    String? backgroundUrl,
  });
  Future<String> uploadImage({
    required String userId,
    required File image,
    required String folder,
    String bucketName = 'avatar',
    String? uniqueFileName,
  });
  Future<List<UserModel>> getSuggestedUsers(String currentUserId);
}

class RemoteUserDatasourceImpl implements RemoteUserDatasource {
  final SupabaseClient client;
  RemoteUserDatasourceImpl({required this.client});
  @override
  Future<UserModel> getUserById(String userId) async {
    final response = await client
        .from('users')
        .select()
        .eq('id', userId)
        .single();
    if (response.isNotEmpty) {
      return UserModel.fromJson(response);
    }
    throw ServerException();
  }

  @override
  Future<UserModel> updateUser({
    required String id,
    String? username,
    String? name,
    String? bio,
    String? profileAvatar,
    String? backgroundUrl,
  }) async {
    final updateData = <String, dynamic>{
      if (username != null) 'username': username,
      if (name != null) 'name': name,
      if (bio != null) 'bio': bio,
      if (profileAvatar != null) 'image_url': profileAvatar,
      if (backgroundUrl != null) 'background_url': backgroundUrl,
    };
    final response = await client
        .from('users')
        .update(updateData)
        .eq('id', id)
        .select()
        .single();
    return UserModel.fromJson(response);
  }

  @override
  Future<String> uploadImage({
    required String userId,
    required File image,
    required String folder,
    String bucketName = 'avatar',
    String? uniqueFileName,
  }) async {
    final fileExt = image.path.split('.').last;
    final fileName = uniqueFileName ?? folder;
    final storagePath = '$userId/$fileName.$fileExt';

    await client.storage
        .from(bucketName)
        .upload(
          storagePath,
          image,
          fileOptions: const FileOptions(upsert: true),
        );

    final publicUrl = client.storage.from(bucketName).getPublicUrl(storagePath);
    // Append a timestamp to the URL to bypass CachedNetworkImage's cache
    return '$publicUrl?t=${DateTime.now().millisecondsSinceEpoch}';
  }

  @override
  Future<List<UserModel>> getSuggestedUsers(String currentUserId) async {
    // Get IDs of users current user is already following
    final followingResponse = await client
        .from('follows')
        .select('following_id')
        .eq('follower_id', currentUserId);

    final List<String> followingIds = (followingResponse as List)
        .map((e) => e['following_id'] as String)
        .toList();
    followingIds.add(currentUserId); // Also exclude the current user

    final response = await client
        .from('users')
        .select()
        .not('id', 'in', followingIds)
        .order('followers_count', ascending: false)
        .limit(10);

    return response.map<UserModel>((e) => UserModel.fromJson(e)).toList();
  }
}
