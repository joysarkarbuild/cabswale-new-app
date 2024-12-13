import 'dart:io';

import 'package:cabswalle/constants/url_constants.dart';
import 'package:cabswalle/routes/app_pages.dart';
import 'package:cabswalle/routes/app_routes.dart';
import 'package:cabswalle/services/logger_service.dart';
import 'package:cabswalle/services/login_manager.dart';
import 'package:cabswalle/services/snackbar_service.dart';
import 'package:dio/dio.dart';
import 'package:go_router/go_router.dart';

class ApiService {
  static final ApiService _instance = ApiService._internal();
  late Dio _dio;

  // Private constructor for singleton
  ApiService._internal() {
    _dio = Dio(
      BaseOptions(
        baseUrl: ApiUrls.baseUrl,
        connectTimeout: const Duration(seconds: 10),
        receiveTimeout: const Duration(seconds: 10),
      ),
    );

// Add an interceptor to set the token dynamically
    _dio.interceptors.add(InterceptorsWrapper(
      onRequest: (options, handler) {
        // Set the latest token in headers before every request
        options.headers["idToken"] = LoginManager.jwtToken;
        return handler.next(options); // Continue with the request
      },
    ));

    _dio.interceptors.add(InterceptorsWrapper(
      onRequest: (options, handler) {
        LoggerService.logInfo("Request: ${options.method} ${options.uri}");
        return handler.next(options);
      },
      onResponse: (response, handler) {
        LoggerService.logInfo(
            "Response: ${response.statusCode} ${response.data}");
        return handler.next(response);
      },
      onError: (DioException error, handler) {
        _handleError(error); // Handle error here
        return handler.next(error);
      },
    ));
  }

  // Public factory method to return the same instance
  factory ApiService() {
    return _instance;
  }

  // GET request
  Future<Response?> get(String endpoint,
      {Map<String, dynamic>? queryParams}) async {
    try {
      final response = await _dio.get(endpoint, queryParameters: queryParams);
      return response;
    } on DioException catch (e) {
      _handleError(e);
      return null;
    }
  }

  // POST request
  Future<Response?> post(String endpoint, {Map<String, dynamic>? data}) async {
    try {
      if (data != null) {
        LoggerService.logInfo("Data $data");
      }
      final response = await _dio.post(endpoint, data: data);
      return response;
    } on DioException catch (e) {
      _handleError(e);
      return null;
    }
  }

  // PUT request
  Future<Response?> put(String endpoint, {Map<String, dynamic>? data}) async {
    try {
      final response = await _dio.put(endpoint, data: data);
      return response;
    } on DioException catch (e) {
      _handleError(e);
      return null;
    }
  }

  // DELETE request
  Future<Response?> delete(String endpoint,
      {Map<String, dynamic>? data}) async {
    try {
      final response = await _dio.delete(endpoint, data: data);
      return response;
    } on DioException catch (e) {
      _handleError(e);
      return null;
    }
  }

  // Error handler
  void _handleError(DioException error) async {
    String errorMessage = 'An unexpected error occurred';
    LoggerService.logError(error.toString());
    // Check for 401 Unauthorized
    if (error.response?.statusCode == 401) {
      LoggerService.logError("User dosen't authenticated");
      await LoginManager().clearLoginStatus();
      GoRouter.of(GlobalNavigation.instance.navigatorKey.currentContext!)
          .goNamed(Names.login);
      return;
    } else if (error.type == DioExceptionType.connectionTimeout) {
      errorMessage = 'Connection timeout';
    } else if (error.type == DioExceptionType.sendTimeout) {
      errorMessage = 'Send timeout';
    } else if (error.type == DioExceptionType.receiveTimeout) {
      errorMessage = 'Receive timeout';
    } else if (error.type == DioExceptionType.badResponse) {
      errorMessage =
          'Received invalid status code: ${error.response?.statusCode}';
    } else if (error.type == DioExceptionType.cancel) {
      errorMessage = 'Request to API server was cancelled';
    } else if (error.type == DioExceptionType.connectionError) {
      errorMessage = 'No internet connection';
    } else if (error is SocketException) {
      errorMessage = 'Network error: Please check your connection';
    } else if (error.type == DioExceptionType.unknown) {
      errorMessage = 'Unknown error occurred: ${error.message}';
    }

    // Show the error in a Snackbar
    SnackbarUtils.showErrorSnackBar(message: errorMessage);
  }
}
