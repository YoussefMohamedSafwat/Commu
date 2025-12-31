import 'dart:convert';
import 'dart:developer';
import 'package:cleanarch/core/Error/exceptions.dart';
import 'package:cleanarch/core/constants/urls.dart';
import 'package:cleanarch/features/Comments/data/models/comment_model.dart';
import 'package:dartz/dartz.dart';
import 'package:http/http.dart' as http;

abstract class RemoteCommentDatasource {
  Future<List<CommentModel>> getCommentsByPostId(int postId);
  Future<Unit> deleteComment(int commentId);
  Future<CommentModel> updateComment({
    required int commentID,
    required String commentBody,
  });
  Future<CommentModel> addComment({
    required String commentbody,
    required int postid,
    required int userid,
  });
}

class RemoteCommentDatasourceImpl implements RemoteCommentDatasource {
  final http.Client client;
  RemoteCommentDatasourceImpl({required this.client});
  @override
  Future<List<CommentModel>> getCommentsByPostId(int postId) async {
    final response = await client.get(
      Uri.parse("$dummyJsonUrl/comments/post/$postId"),
    );
    if (response.statusCode == 200) {
      final List<dynamic> jsondata =
          jsonDecode(response.body)['comments'] as List;
      final commentModels = jsondata
          .map<CommentModel>((jsonitem) => CommentModel.fromJson(jsonitem))
          .toList();
      return commentModels;
    } else {
      throw ServerException();
    }
  }

  @override
  Future<CommentModel> addComment({
    required String commentbody,
    required int postid,
    required int userid,
  }) async {
    final body = {
      'body': commentbody,
      'postId': postid.toString(),
      'userId': userid.toString(),
    };
    final response = await client.post(
      Uri.parse("$dummyJsonUrl/comments/add"),
      body: body,
    );
    if (response.statusCode == 201) {
      final jsondata = jsonDecode(response.body);
      return CommentModel.fromJson(jsondata);
    } else {
      throw ServerException();
    }
  }

  @override
  Future<Unit> deleteComment(int commentId) async {
    final response = await client.delete(
      Uri.parse('$dummyJsonUrl/comments/$commentId'),
    );

    if (response.statusCode == 200) {
      return Future.value(unit);
    }
    log(response.body);
    throw ServerException();
  }

  @override
  Future<CommentModel> updateComment({
    required int commentID,
    required String commentBody,
  }) async {
    final response = await client.put(
      Uri.parse("$dummyJsonUrl/comments/$commentID"),
      body: {'body': commentBody},
    );

    if (response.statusCode == 200) {
      final jsondata = jsonDecode(response.body);
      return CommentModel.fromJson(jsondata);
    } else {
      throw ServerException();
    }
  }
}
