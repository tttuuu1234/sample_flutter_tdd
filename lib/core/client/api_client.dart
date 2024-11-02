import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sample_flutter_tdd/core/client/exception.dart';

final apiClientProvider = Provider<ApiClient>((ref) {
  return ApiClient();
});

class ApiClient {
  ApiClient({Dio? dio}) : _dio = dio ?? Dio() {
    _setupDio();
  }

  final Dio _dio;

  void _setupDio() {
    const token = String.fromEnvironment('TOKEN');
    print(token);
    _dio.options.baseUrl = 'https://api.github.com';
    _dio.options.connectTimeout = const Duration(seconds: 5);
    _dio.options.receiveTimeout = const Duration(seconds: 3);
    _dio.options.headers = {
      // 'Accept': 'application/vnd.github+json',
      'X-GitHub-Api-Version': '2022-11-28',
      'Authorization': 'Bearer $token'
    };

    // インターセプターの設定
    _dio.interceptors.add(LogInterceptor(
      request: true,
      requestHeader: true,
      requestBody: true,
      responseHeader: true,
      responseBody: true,
      error: true,
    ));
  }

  Future<dynamic> get(
    String path, {
    Map<String, dynamic>? queryParameters,
  }) async {
    try {
      final response = await _dio.get(
        path,
        queryParameters: queryParameters,
      );
      return _handleResponse(response);
    } on DioException catch (e) {
      throw _handleDioError(e);
    } catch (e) {
      throw ApiException('Unknown error occurred: $e');
    }
  }

  dynamic _handleResponse(Response response) {
    switch (response.statusCode) {
      case 200:
      case 201:
        return response.data;
      case 204:
        return null;
      case 400:
        throw BadRequestException(response.data?.toString());
      case 401:
        throw UnauthorizedException(response.data?.toString());
      case 403:
        throw ForbiddenException(response.data?.toString());
      case 404:
        throw NotFoundException(response.data?.toString());
      case 500:
        throw ServerException(response.data?.toString());
      default:
        throw ApiException(
          'Unknown error occurred: ${response.statusCode}',
        );
    }
  }

  Exception _handleDioError(DioException error) {
    switch (error.type) {
      case DioExceptionType.connectionTimeout:
      case DioExceptionType.sendTimeout:
      case DioExceptionType.receiveTimeout:
        return TimeoutException(error.message);
      case DioExceptionType.badResponse:
        return _handleResponse(error.response!);
      case DioExceptionType.cancel:
        return RequestCancelledException(error.message);
      default:
        return NetworkException(error.message);
    }
  }
}
