import 'package:cleanarch/core/Error/exceptions.dart';
import 'package:cleanarch/features/Posts/data/models/post_model.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter/widgets.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

abstract class RemoteDatasources {
  Future<List<PostModel>> getAllPosts(int skip);
  Future<PostModel> getPostById(int postid);
  Future<List<PostModel>> getPostByUserId(String uid);
  Future<Unit> deletePost(int postId);
  Future<Unit> updatePost(PostModel postModel);
  Future<Unit> addPost(PostModel postModel);
  Future<List<PostModel>> getLikedPosts(String uid);
}

class RemoteDatasourcesImpl implements RemoteDatasources {
  final SupabaseClient client;

  RemoteDatasourcesImpl({required this.client});

  @override
  Future<Unit> addPost(PostModel postModel) async {
    await client.from('posts').insert(postModel.toJsonInsertion());
    return Future.value(unit);
  }

  Future<void> _deleteImagesFromBucket(List<String> urls) async {
    if (urls.isEmpty) return;
    final paths = urls.map((url) {
      // Remove query parameters like '?t=...'
      final cleanUrl = url.split('?').first;
      final uri = Uri.parse(cleanUrl);
      final pathSegments = uri.pathSegments;
      final bucketIndex = pathSegments.indexOf('Posts');
      if (bucketIndex != -1 && bucketIndex < pathSegments.length - 1) {
        return pathSegments.sublist(bucketIndex + 1).join('/');
      }
      return '';
    }).where((p) => p.isNotEmpty).toList();

    if (paths.isNotEmpty) {
      await client.storage.from('Posts').remove(paths);
    }
  }

  @override
  Future<Unit> deletePost(int postId) async {
    final response = await client
        .from('posts')
        .select('images_url')
        .eq('id', postId)
        .single();
    final images = List<String>.from(response['images_url'] ?? []);
    
    await _deleteImagesFromBucket(images);
    await client.from("posts").delete().eq('id', postId);
    return Future.value(unit);
  }

  @override
  Future<List<PostModel>> getAllPosts(int skip) async {
    debugPrint("getting all posts .....");
    final response = await client
        .from('posts')
        .select()
        .order('created_at', ascending: false)
        .range(skip, skip + 5);

    debugPrint("supabase response : $response");

    return response
        .map<PostModel>((postmodel) => PostModel.fromJson(postmodel))
        .toList();
  }

  @override
  Future<PostModel> getPostById(int postid) async {
    final response = await client
        .from('posts')
        .select()
        .eq('id', postid)
        .single();
    if (response.isNotEmpty) {
      return PostModel.fromJson(response);
    }
    throw ServerException();
  }

  @override
  Future<List<PostModel>> getLikedPosts(String uid) async {
    final response = await client
        .from('reacts')
        .select('post_id,posts(*)')
        .eq('user_id', uid)
        .order('created_at', ascending: false);
    return response.map((row) {
      final postJson = row['posts'] as Map<String, dynamic>;
      return PostModel.fromJson(postJson);
    }).toList();
  }

  @override
  Future<Unit> updatePost(PostModel postModel) async {
    final response = await client
        .from('posts')
        .select('images_url')
        .eq('id', postModel.id)
        .single();
    final oldImages = List<String>.from(response['images_url'] ?? []);
    
    final newImages = postModel.imagesUrl ?? [];
    final removedImages = oldImages.where((url) => !newImages.contains(url)).toList();
    
    await _deleteImagesFromBucket(removedImages);

    await client
        .from('posts')
        .update({
          'title': postModel.title,
          'body': postModel.body,
          'tags': postModel.tags,
          'images_url': postModel.imagesUrl,
        })
        .eq('id', postModel.id);
    return Future.value(unit);
  }

  @override
  Future<List<PostModel>> getPostByUserId(String uid) async {
    final response = await client
        .from('posts')
        .select()
        .eq('user_id', uid)
        .order('created_at', ascending: false);
    final postmodel = response.map((post) => PostModel.fromJson(post)).toList();
    return postmodel;
  }
}
