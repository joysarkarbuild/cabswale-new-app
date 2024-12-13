import 'package:cabswalle/modules/splash/data/models/app_data_model.dart';
import 'package:cabswalle/services/firestore_service.dart'; // Import your ApiService

class AppDataRepository {
  final FirestoreUtils _firestoreService;

  AppDataRepository({FirestoreUtils? apiService})
      : _firestoreService =
            apiService ?? FirestoreUtils(); // Use ApiService instead of Dio

  Future<AppDataModel> fetchAppVersion() async {
    try {
      // Use the ApiService's post method to make the API call
      final response = await _firestoreService.getDocument("settings", "app");

      if (response != null && response.exists) {
        return AppDataModel.fromJson(response.data() as Map<String, dynamic>);
      } else {
        throw Exception('Failed to fetch app data.');
      }
    } catch (e) {
      // Handle any other errors
      throw Exception('Unexpected error fetching app data: $e');
    }
  }
}
