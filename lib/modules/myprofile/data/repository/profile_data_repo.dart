import 'package:cabswalle/constants/url_constants.dart';
import 'package:cabswalle/modules/myprofile/data/models/user_profile_data_model.dart';
import 'package:cabswalle/services/api_service.dart';
import 'package:cabswalle/services/login_manager.dart'; // Import your ApiService

class MyProfileDataRepo {
  final ApiService _apiService;

  MyProfileDataRepo({ApiService? apiService})
      : _apiService =
            apiService ?? ApiService(); // Use ApiService instead of Dio

  Future<UserProfileDataModel> fetchMyProfileData() async {
    try {
      // Use the ApiService's post method to make the API call
      final response = await _apiService.post(ApiUrls.userDetails, data: {
        "userId": LoginManager.userId,
        'type': "profile",
      });

      if (response != null &&
          response.statusCode == 200 &&
          response.data["status"]) {
        return UserProfileDataModel.fromJson(
            response.data["data"] as Map<String, dynamic>);
      } else {
        throw Exception('${response!.data["message"]}');
      }
    } catch (e) {
      // Handle any other errors
      throw Exception('Unexpected error fetching app data: $e');
    }
  }
}
