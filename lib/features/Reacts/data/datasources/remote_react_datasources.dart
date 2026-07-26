import 'dart:developer';

import 'package:supabase_flutter/supabase_flutter.dart';

abstract class RemoteReactDatasource {
  Future<void> addReact(int postId, String userId);
  Future<void> removeReact(int postId, String userId);
  Future<Set<int>> getReactedPostIds(String userId, List<int> postIds);
}

class RemoteReactDatasourceImpl implements RemoteReactDatasource {
  final SupabaseClient client;
  RemoteReactDatasourceImpl({required this.client});

  @override
  Future<void> addReact(int postId, String userId) async {
    log("adding a react ");
    return await client.from('reacts').insert({
      'post_id': postId,
      'user_id': userId,
    });
  }

  @override
  Future<void> removeReact(int postId, String userId) async {
    await client
        .from('reacts')
        .delete()
        .eq('post_id', postId)
        .eq('user_id', userId);
  }

  @override
  Future<Set<int>> getReactedPostIds(String userId, List<int> postIds) async {
    if (postIds.isEmpty) return {};
    final rows = await client
        .from('reacts')
        .select('post_id')
        .eq('user_id', userId)
        .inFilter('post_id', postIds);
    return rows.map<int>((r) => r['post_id'] as int).toSet();
  }
}
