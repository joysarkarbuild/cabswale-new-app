import 'dart:io';
import 'package:cabswalle/services/driver_service.dart';
import 'package:cabswalle/services/firebase_storage_service.dart';
import 'package:cabswalle/services/firestore_service.dart';
import 'package:cabswalle/services/login_manager.dart';

class UpdateUserDataRepo {
  final FirestoreUtils _apiService;

  UpdateUserDataRepo({FirestoreUtils? apiService})
      : _apiService = apiService ?? FirestoreUtils();

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
        await _apiService.updateDocument("drivers", LoginManager.userId!, {
          "profile_image": profileImageUrl,
          "name": name,
          "city": city,
          "experience": exprience,
        });
        DriverService.instance.loadDriverModel();

        return {"status": true, "profileImage": profileImageUrl};
      } else {
        await _apiService.updateDocument("drivers", LoginManager.userId!, {
          "name": name,
          "city": city,
          "experience": exprience,
        });
        DriverService.instance.loadDriverModel();
        return {"status": true, "profileImage": ""};
      }
    } catch (e) {
      // Handle any other errors
      throw Exception('Unexpected error fetching app data: $e');
    }
  }

  Future<bool> updateTopRoutes({required List topRoutes}) async {
    try {
      await _apiService.updateDocument("drivers", LoginManager.userId!, {
        "routes": topRoutes,
      });

      return true;
    } catch (e) {
      // Handle any other errors
      throw Exception('Unexpected error fetching app data: $e');
    }
  }

  Future<bool> updateVehicles({required List vehicles}) async {
    try {
      await _apiService.updateDocument("drivers", LoginManager.userId!, {
        "vehicles": vehicles,
      });
      return true;
    } catch (e) {
      // Handle any other errors
      throw Exception('Unexpected error fetching app data: $e');
    }
  }
}
