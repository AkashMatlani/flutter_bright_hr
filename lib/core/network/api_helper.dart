import 'package:dio/dio.dart';
import 'package:flutter_bright_hr/core/network/api_exception.dart';
import 'package:flutter_bright_hr/models/comment.dart';
import 'package:flutter_bright_hr/models/post.dart';
import 'package:flutter_bright_hr/utils/constant.dart';

class ApiHelper {
  final Dio _dio = Dio(BaseOptions(baseUrl: baseURL));

  Future<List<Post>> fetchPosts() async {
    try {
      final response = await _dio.get("/posts");
      return (response.data as List).map((e) => Post.fromJson(e)).toList();
    } on DioException catch (e) {
      throw ApiException('$failedToLoadPosts:  ${e.message}');
    } catch (e) {
      throw ApiException('$anUnknownErrorOccurred ${e.toString()}');
    }
  }

  Future<Post> fetchPostDetails(int postId) async {
    try {
      final response = await _dio.get("/posts/$postId");
      return Post.fromJson(response.data);
    } on DioException catch (e) {
      throw ApiException('$failedToLoadPostDetails:  ${e.message}');
    } catch (e) {
      throw ApiException('$anUnknownErrorOccurred ${e.toString()}');
    }
  }

  Future<List<Comment>> fetchComments(int postId) async {
    try {
      final response = await _dio.get("/posts/$postId/comments");
      return (response.data as List).map((e) => Comment.fromJson(e)).toList();
    } on DioException catch (e) {
      throw Exception('$failedToLoadComments: ${e.message}');
    } catch (e) {
      throw ApiException('$anUnknownErrorOccurred ${e.toString()}');
    }
  }
}
