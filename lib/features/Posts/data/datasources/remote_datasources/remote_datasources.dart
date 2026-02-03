import 'dart:convert';
import 'dart:developer';
import 'package:cleanarch/core/Error/exceptions.dart';
import 'package:cleanarch/core/constants/urls.dart';
import 'package:cleanarch/features/Posts/data/models/post_model.dart';
import 'package:dartz/dartz.dart';
import 'package:http/http.dart' as http;

abstract class RemoteDatasources {
  Future<List<PostModel>> getAllPosts(int skip);
  Future<PostModel> getPostById(int postid);
  Future<List<PostModel>> getPostByUserId(int uid);
  Future<Unit> deletePost(int postId);
  Future<Unit> updatePost(PostModel postModel);
  Future<Unit> addPost(PostModel postModel);
}

class RemoteDatasourcesImpl implements RemoteDatasources {
  final http.Client client;

  RemoteDatasourcesImpl({required this.client});

  @override
  Future<Unit> addPost(PostModel postModel) async {
    final body = {'title': postModel.title, 'body': postModel.body};

    final response = await client.post(
      Uri.parse("$BASE_URL/posts/"),
      body: body,
    );

    if (response.statusCode == 201) {
      return Future.value(unit);
    } else {
      throw ServerException();
    }
  }

  @override
  Future<Unit> deletePost(int postId) async {
    final response = await client.delete(
      Uri.parse("$dummyJsonUrl/posts/$postId"),
    );

    if (response.statusCode == 200) {
      return Future.value(unit);
    } else {
      throw ServerException();
    }
  }

  @override
  Future<List<PostModel>> getAllPosts(int skip) async {
    final response = await client.get(
      Uri.parse("$dummyJsonUrl/posts?limit=5&skip=$skip"),
      headers: {"Content-Type": "application/json"},
    );

    if (response.statusCode == 200) {
      final List decodedjson = jsonDecode(response.body)['posts'] as List;

      final List<PostModel> postmodels = decodedjson
          .map<PostModel>((postmodel) => PostModel.fromJson(postmodel))
          .toList();

      return postmodels;
    } else {
      throw ServerException();
    }
  }

  @override
  Future<PostModel> getPostById(int postid) async {
    final response = await client.get(
      Uri.parse("$dummyJsonUrl/posts/$postid"),
      headers: {"Content-Type": "application/json"},
    );

    if (response.statusCode == 200) {
      final Map<String, dynamic> decodedjson = jsonDecode(response.body);

      final PostModel postModel = PostModel.fromJson(decodedjson);

      return postModel;
    } else {
      throw ServerException();
    }
  }

  @override
  Future<Unit> updatePost(PostModel postModel) async {
    final postId = postModel.id;
    final body = {"title": postModel.title, "body": postModel.body};

    final response = await client.patch(
      Uri.parse("$dummyJsonUrl/posts/$postId"),
      body: body,
    );

    if (response.statusCode == 200) {
      return Future.value(unit);
    } else {
      throw ServerException();
    }
  }

  @override
  Future<List<PostModel>> getPostByUserId(int uid) async {
    // TODO: implement getPostByUserId
    final response = await client.get(
      Uri.parse("$dummyJsonUrl/posts/user/$uid"),
      headers: {"Content-Type": "application/json"},
    );
    if (response.statusCode == 200) {
      final List decodedjson = jsonDecode(response.body)['posts'] as List;

      final List<PostModel> postmodels = decodedjson
          .map<PostModel>((postmodel) => PostModel.fromJson(postmodel))
          .toList();
      log("first post : ${postmodels.isEmpty}");
      return postmodels;
    }
    throw ServerException();
  }
}
