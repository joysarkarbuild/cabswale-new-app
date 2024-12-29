import 'package:cabswalle/modules/myprofile/data/models/user_profile_data_model.dart';
import 'package:cabswalle/services/firestore_service.dart';

class MyProfileDataRepo {
  final FirestoreUtils _apiService;

  MyProfileDataRepo({
    FirestoreUtils? apiService,
  }) : _apiService =
            apiService ?? FirestoreUtils(); // Use ApiService instead of Dio

  Future<UserProfileDataModel> fetchMyProfileData(
      {required String userId}) async {
    try {
      // Use the ApiService's post method to make the API call
      final response = await _apiService.getDocument("drivers", userId);
      final analiticsData =
          await _apiService.getDocument("driverAnalytics", userId);
      if (response!.exists) {
        UserProfileDataModel profile = UserProfileDataModel.fromJson(
            response.data() as Map<String, dynamic>);

        if (analiticsData!.exists) {
          Map<String, dynamic> callData =
              analiticsData.data() as Map<String, dynamic>;
          UserProfileDataModel newProfile = profile.copyWith(
              callDoneCount: callData["outgoingCalls"] ?? 0,
              callReceivedCount: callData["incomingCalls"] ?? 0);
          return newProfile;
        }

        return profile;
      } else {
        throw Exception('No Data Available with the uderId');
      }
    } catch (e) {
      // Handle any other errors
      throw Exception('Unexpected error fetching app data: $e');
    }
  }
}
