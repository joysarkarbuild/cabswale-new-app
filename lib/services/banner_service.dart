import 'package:cabswalle/services/firestore_service.dart';
import 'package:cabswalle/services/logger_service.dart';
import 'package:cabswalle/services/snackbar_service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class BannerService {
  // Static instance for Singleton pattern
  static final BannerService _instance = BannerService._internal();

  // Static field to store the data
  static Map<String, dynamic>? bannersData;

  // FirebaseFirestore instance
  final FirestoreUtils firestoreUtils = FirestoreUtils();

  // Private constructor
  BannerService._internal();

  // Factory constructor to return the single instance of FirebaseService
  factory BannerService() {
    return _instance;
  }

  // Fetch the 'banners' document from 'settings' collection
  Future<void> loadBannersData() async {
    try {
      DocumentSnapshot<Object?>? documentSnapshot =
          await firestoreUtils.getDocument('settings', 'banners');

      if (documentSnapshot != null && documentSnapshot.exists) {
        // Store data in the static field
        bannersData = documentSnapshot.data() as Map<String, dynamic>?;
      } else {
        SnackbarUtils.showErrorSnackBar(
            message: "Banner Document does not exist");
        LoggerService.logInfo("Document does not exist");
      }
    } catch (e) {
      SnackbarUtils.showErrorSnackBar(message: e.toString());
      LoggerService.logInfo("Error fetching banners data: $e");
    }
  }

  // Accessor for the banners data
  static Map<String, dynamic>? getBannersData() {
    return bannersData;
  }
}
