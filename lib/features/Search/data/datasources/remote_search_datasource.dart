import 'package:cleanarch/features/Posts/data/models/post_model.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

abstract class RemoteSearchDatasource {
  Future<List<PostModel>> searchPostsByTag(String tag);
  Future<List<PostModel>> searchPostsByUsername(String username);
}

class RemoteSearchDatasourceImpl implements RemoteSearchDatasource {
  final SupabaseClient client;
  RemoteSearchDatasourceImpl({required this.client});

  @override
  Future<List<PostModel>> searchPostsByTag(String tag) async {
    final cleanTag = tag.replaceAll('#', '').trim().toLowerCase();

    final response = await client
        .from('posts')
        .select('*, users(*)')
        .contains('tags', [cleanTag])
        .order('created_at', ascending: false)
        .limit(20);

    return response.map<PostModel>((json) => PostModel.fromJson(json)).toList();
  }

  @override
  Future<List<PostModel>> searchPostsByUsername(String username) async {
    final searchTerm = '%${username.trim()}%';

    final response = await client
        .from('posts')
        .select('*, users!inner(*)')
        .ilike('users.username', searchTerm)
        .order('created_at', ascending: false)
        .limit(20);

    return response.map<PostModel>((json) => PostModel.fromJson(json)).toList();
  }
}
