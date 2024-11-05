import 'package:cabswalle/constants/url_constants.dart';
import 'package:cabswalle/services/api_service.dart';
import 'package:cabswalle/services/login_status_service.dart';

class UpdateUserDataRepo {
  final ApiService _apiService;

  UpdateUserDataRepo({ApiService? apiService})
      : _apiService = apiService ?? ApiService();

  Future<bool> updateUserProfile(
      {required String name,
      required String city,
      required int exprience}) async {
    try {
      // Use the ApiService's post method to make the API call
      final response = await _apiService.post(ApiUrls.updateUserDetails, data: {
        'type': "profile",
        "userId": LoginManager.userId,
        "data": {
          "name": name,
          "city": city,
          "exprience": exprience,
        }
      });

      if (response != null &&
          response.statusCode == 200 &&
          response.data["status"]) {
        return true;
      } else {
        throw Exception(
            'Failed to update user profile. Status code: ${response?.statusCode} Error: ${response!.data["message"]}');
      }
    } catch (e) {
      // Handle any other errors
      throw Exception('Unexpected error fetching app data: $e');
    }
  }
}
