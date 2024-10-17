import 'package:cabswalle/constants/url_constants.dart';
import 'package:cabswalle/services/api_service.dart';

class OtpDataRepo {
  // Method to authenticate using authId and idToken
  static Future<Map<String, dynamic>> auth({
    required String idToken,
    required String authId,
  }) async {
    try {
      // Sending the POST request using the ApiService
      final response = await ApiService().post(
        ApiUrls.auth, // Endpoint for authentication
        data: {
          'token_type': 'id_token',
          'idToken': idToken,
          'authId': authId,
        },
      );

      if (response != null && response.statusCode == 200) {
        return response.data;
      } else {
        throw Exception(
            'Failed to authenticate. Status code: ${response?.statusCode}');
      }
    } catch (e) {
      // Throwing an exception if any error occurs
      throw Exception('An error occurred while authenticating: $e');
    }
  }
}
