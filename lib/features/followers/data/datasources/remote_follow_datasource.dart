import 'package:cleanarch/core/Error/exceptions.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:cleanarch/features/user/data/models/user_model.dart';
import 'package:cleanarch/features/user/domain/entities/user.dart' as domain;

abstract class RemoteFollowDatasource {
  Future<void> toggleFollow(String followerId, String followingId);
  Future<bool> checkIsFollowing(String followerId, String followingId);
  Future<List<domain.User>> getFollowers(String userId);
  Future<List<domain.User>> getFollowing(String userId);
}

class RemoteFollowDatasourceImpl implements RemoteFollowDatasource {
  final SupabaseClient client;

  RemoteFollowDatasourceImpl({required this.client});

  @override
  Future<void> toggleFollow(String followerId, String followingId) async {
    try {
      final isFollowing = await checkIsFollowing(followerId, followingId);
      if (isFollowing) {
        await client
            .from('follows')
            .delete()
            .eq('follower_id', followerId)
            .eq('following_id', followingId);
      } else {
        await client.from('follows').insert({
          'follower_id': followerId,
          'following_id': followingId,
        });
      }
    } catch (e) {
      throw ServerException();
    }
  }

  @override
  Future<bool> checkIsFollowing(String followerId, String followingId) async {
    try {
      final response = await client
          .from('follows')
          .select()
          .eq('follower_id', followerId)
          .eq('following_id', followingId);
      return response.isNotEmpty;
    } catch (e) {
      throw ServerException();
    }
  }

  @override
  Future<List<domain.User>> getFollowers(String userId) async {
    try {
      final response = await client
          .from('follows')
          .select('users:follower_id(*)')
          .eq('following_id', userId);

      return response
          .map<domain.User>((data) => UserModel.fromJson(data['users']))
          .toList();
    } catch (e) {
      throw ServerException();
    }
  }

  @override
  Future<List<domain.User>> getFollowing(String userId) async {
    try {
      final response = await client
          .from('follows')
          .select('users:following_id(*)')
          .eq('follower_id', userId);

      return response
          .map<domain.User>((data) => UserModel.fromJson(data['users']))
          .toList();
    } catch (e) {
      throw ServerException();
    }
  }
}
