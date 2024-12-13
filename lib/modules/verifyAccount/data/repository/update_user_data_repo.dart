import 'dart:io';
import 'package:cabswalle/constants/url_constants.dart';
import 'package:cabswalle/modules/myprofile/data/models/user_profile_data_model.dart';
import 'package:cabswalle/services/api_service.dart';
import 'package:cabswalle/services/firebase_storage_service.dart';
import 'package:cabswalle/services/login_manager.dart';

class UpdateUserDataRepo {
  final ApiService _apiService;

  UpdateUserDataRepo({ApiService? apiService})
      : _apiService = apiService ?? ApiService();

  Future<Map<String, dynamic>> updateUserProfile(
      {required String name,
      required String city,
      required int exprience,
      File? profilePic}) async {
    try {
      // Use the ApiService's post method to make the API call
      String profileImageUrl = "";
      if (profilePic != null) {
        profileImageUrl =
            await FirebaseStorageService.uploadProfileImageToFirebase(
                    profilePic) ??
                "";
      }
      if (profileImageUrl.isNotEmpty) {
        final response =
            await _apiService.post(ApiUrls.updateUserDetails, data: {
          'type': "profile",
          "userId": LoginManager.userId,
          "data": {
            "name": name,
            "city": city,
            "experience": exprience,
            "profileImage": profileImageUrl,
          }
        });
        if (response != null &&
            response.statusCode == 200 &&
            response.data["status"]) {
          return {"status": true, "profileImage": profileImageUrl};
        } else {
          throw Exception(
              'Failed to update user profile. Status code: ${response?.statusCode} Error: ${response!.data["message"]}');
        }
      } else {
        final response =
            await _apiService.post(ApiUrls.updateUserDetails, data: {
          'type': "profile",
          "userId": LoginManager.userId,
          "data": {
            "name": name,
            "city": city,
            "experience": exprience,
          }
        });
        if (response != null &&
            response.statusCode == 200 &&
            response.data["status"]) {
          return {"status": true, "profileImage": ""};
        } else {
          throw Exception(
              'Failed to update user profile. Status code: ${response?.statusCode} Error: ${response!.data["message"]}');
        }
      }
    } catch (e) {
      // Handle any other errors
      throw Exception('Unexpected error fetching app data: $e');
    }
  }

  Future<bool> updateTopRoutes({required List topRoutes}) async {
    try {
      final response = await _apiService.post(ApiUrls.updateUserDetails, data: {
        'type': "profile",
        "userId": LoginManager.userId,
        "data": {
          "routes": topRoutes,
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

  Future<bool> updateVehicles({required List vehicles}) async {
    try {
      final response = await _apiService.post(ApiUrls.updateUserDetails, data: {
        'type': "profile",
        "userId": LoginManager.userId,
        "data": {
          "vehicles": vehicles,
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

  Future<bool> updateNotificationLocations(
      {required List<NotificationLocation> notificationLocations}) async {
    try {
      final response = await _apiService.post(ApiUrls.updateUserDetails, data: {
        'type': "profile",
        "userId": LoginManager.userId,
        "data": {
          "notificationLocations": [
            ...notificationLocations.map(
              (e) => e.toJson(),
            )
          ],
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

  Future<bool> updateGetDutyAlerts({required bool getDutyAlerts}) async {
    try {
      final response = await _apiService.post(ApiUrls.updateUserDetails, data: {
        'type': "profile",
        "userId": LoginManager.userId,
        "data": {
          "getDutyAlerts": getDutyAlerts,
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
