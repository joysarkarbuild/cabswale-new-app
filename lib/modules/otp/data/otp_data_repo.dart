import 'package:dio/dio.dart';

class OtpDataRepo {
  static Future<Map<String, dynamic>> auth({
    required String idToken,
    required String authId,
  }) async {
    Dio dio = Dio();

    try {
      Response response = await dio.post(
        'https://us-central1-cabswale-dev.cloudfunctions.net/auth-auth',
        data: {
          'token_type': 'id_token',
          'idToken': idToken,
          'authId': authId,
        },
      );

      if (response.statusCode == 200) {
        return response.data;
      } else {
        throw Exception(
            'Failed to authenticate. Status code: ${response.statusCode}');
      }
    } on DioException catch (dioException) {
      if (dioException.type == DioExceptionType.badResponse) {
        throw Exception('Server error: ${dioException.response?.data}');
      } else if (dioException.type == DioExceptionType.connectionTimeout) {
        throw Exception('Connection timeout');
      } else if (dioException.type == DioExceptionType.receiveTimeout) {
        throw Exception('Receive timeout');
      } else if (dioException.type == DioExceptionType.badCertificate) {
        throw Exception('Bad certificate error');
      } else if (dioException.type == DioExceptionType.cancel) {
        throw Exception('Request was cancelled');
      } else if (dioException.type == DioExceptionType.unknown) {
        throw Exception('Network error: ${dioException.message}');
      } else {
        throw Exception('Unexpected error: ${dioException.message}');
      }
    } catch (e) {
      throw Exception('An unexpected error occurred: $e');
    }
  }
}
