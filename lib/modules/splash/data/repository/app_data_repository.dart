import 'package:cabswalle/constants/url_constants.dart';
import 'package:cabswalle/modules/splash/data/models/app_data_model.dart';
import 'package:cabswalle/services/api_service.dart'; // Import your ApiService

class AppDataRepository {
  final ApiService _apiService;

  AppDataRepository({ApiService? apiService})
      : _apiService =
            apiService ?? ApiService(); // Use ApiService instead of Dio

  Future<AppDataModel> fetchAppVersion() async {
    try {
      // Use the ApiService's post method to make the API call
      final response = await _apiService.post(ApiUrls.settings, data: {
        'docId': "app",
      });

      if (response != null &&
          response.statusCode == 200 &&
          response.data["status"]) {
        return AppDataModel.fromJson(
            response.data["data"] as Map<String, dynamic>);
      } else {
        throw Exception(
            'Failed to fetch app data. Status code: ${response?.statusCode}');
      }
    } catch (e) {
      // Handle any other errors
      throw Exception('Unexpected error fetching app data: $e');
    }
  }
}
