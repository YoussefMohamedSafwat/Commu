import 'package:cleanarch/core/Error/exceptions.dart';
import 'package:cleanarch/features/Comments/data/models/comment_model.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter/cupertino.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

abstract class RemoteCommentDatasource {
  Future<List<CommentModel>> getCommentsByPostId(int postId);
  Future<Unit> deleteComment(int commentId);
  Future<CommentModel> updateComment({
    required int commentID,
    required String commentBody,
  });
  Future<CommentModel> addComment({required CommentModel commentmodel});
}

class RemoteCommentDatasourceImpl implements RemoteCommentDatasource {
  final SupabaseClient client;
  RemoteCommentDatasourceImpl({required this.client});
  @override
  Future<List<CommentModel>> getCommentsByPostId(int postId) async {
    final comments = await client
        .from('comments')
        .select()
        .eq('post_id', postId)
        .order('created_at', ascending: false);

    return comments
        .map<CommentModel>((comment) => CommentModel.fromJson(comment))
        .toList();
  }

  @override
  Future<CommentModel> addComment({required CommentModel commentmodel}) async {
    debugPrint(
      "adding a comment : ${commentmodel.postId}${commentmodel.likes}${commentmodel.id} ${commentmodel.body} ${commentmodel.userId}",
    );
    final response = await client
        .from('comments')
        .insert(commentmodel.toJson())
        .select()
        .single();
    return CommentModel.fromJson(response);
  }

  @override
  Future<Unit> deleteComment(int commentId) async {
    await client.from('comments').delete().eq('id', commentId);
    return Future.value(unit);
  }

  @override
  Future<CommentModel> updateComment({
    required int commentID,
    required String commentBody,
  }) async {
    final response = await client
        .from('comments')
        .update({'body': commentBody})
        .eq('id', commentID)
        .select()
        .single();
    return CommentModel.fromJson(response);
  }
}
