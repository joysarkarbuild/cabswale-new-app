import 'package:cabswalle/models/driver_model.dart';
import 'package:cabswalle/services/logger_service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class DriverService {
  // Private constructor for singleton
  DriverService._privateConstructor();

  // The single instance of the class
  static final DriverService _instance = DriverService._privateConstructor();

  // The DriverModel instance
  DriverModel? _driverModel;

  // Getter to access the singleton instance
  static DriverService get instance => _instance;

  // Get the current Firebase user UID
  String get _userId => FirebaseAuth.instance.currentUser?.uid ?? '';

  // Firebase Firestore reference for the 'drivers' collection
  final CollectionReference _driversCollection =
      FirebaseFirestore.instance.collection('drivers');

  // Set the driver model instance (locally)
  void setDriverModel(DriverModel driverModel) {
    _driverModel = driverModel;
  }

  // Get the driver model instance (locally)
  DriverModel? get driverModel => _driverModel;

  // Load the driver model from Firestore using the current user's UID
  Future<void> loadDriverModel() async {
    try {
      final DocumentSnapshot<Map<String, dynamic>> docSnapshot =
          await _driversCollection.doc(_userId).get()
              as DocumentSnapshot<Map<String, dynamic>>;

      if (docSnapshot.exists) {
        _driverModel = DriverModel.fromJson(
            {"id": docSnapshot.id, ...?docSnapshot.data()});

        LoggerService.logInfo("Driver Data : $_driverModel");
      } else {
        throw Exception("Driver data not found for this user.");
      }
    } catch (e) {
      throw Exception("Error loading driver data: $e");
    }
  }

  // Save the driver model to Firestore
  Future<void> saveDriverModel() async {
    try {
      if (_driverModel != null) {
        await _driversCollection
            .doc(_userId)
            .set(_driverModel!.toJson(), SetOptions(merge: true));
      } else {
        throw Exception("No driver model to save.");
      }
    } catch (e) {
      throw Exception("Error saving driver data: $e");
    }
  }

  // Update any field of the driver model
  Future<void> updateDriverField(String fieldName, dynamic value) async {
    try {
      if (_driverModel != null) {
        // Update the field in the local DriverModel
        _updateFieldInDriverModel(fieldName, value);

        // Save the updated DriverModel to Firestore
        await _driversCollection.doc(_userId).update({
          fieldName: value,
        });
      } else {
        throw Exception("No driver model loaded.");
      }
    } catch (e) {
      throw Exception("Error updating field: $e");
    }
  }

  // Helper method to update the field in the local DriverModel
  void _updateFieldInDriverModel(String fieldName, dynamic value) {
    switch (fieldName) {
      case 'name':
        _driverModel = _driverModel?.copyWith(name: value);
        break;
      case 'phoneNo':
        _driverModel = _driverModel?.copyWith(phoneNo: value);
        break;
      case 'conditionAccepted':
        _driverModel = _driverModel?.copyWith(conditionAccepted: value);
        break;
      case 'verified':
        _driverModel = _driverModel?.copyWith(verified: value);
        break;
      case 'autoApproveLeads':
        _driverModel = _driverModel?.copyWith(autoApproveLeads: value);
        break;
      case 'notificationPlace':
        _driverModel = _driverModel?.copyWith(notificationPlace: value);
        break;
      case 'notificationLocations':
        _driverModel = _driverModel?.copyWith(notificationLocations: value);
        break;
      case 'notificationAlert':
        _driverModel = _driverModel?.copyWith(notificationAlert: value);
        break;
      case 'stage':
        _driverModel = _driverModel?.copyWith(stage: value);
        break;
      case 'appVersion':
        _driverModel = _driverModel?.copyWith(appVersion: value);
        break;
      case 'deviceTokens':
        _driverModel = _driverModel?.copyWith(deviceTokens: value);
        break;
      case 'totalLeads':
        _driverModel = _driverModel?.copyWith(totalLeads: value);
        break;
      case 'outGoingCalls':
        _driverModel = _driverModel?.copyWith(outGoingCalls: value);
        break;
      case 'dealCount':
        _driverModel = _driverModel?.copyWith(dealCount: value);
        break;
      case 'customOffer':
        _driverModel = _driverModel?.copyWith(customOffer: value);
        break;
      case 'sessionId':
        _driverModel = _driverModel?.copyWith(sessionId: value);
        break;
      default:
        throw Exception("Field not recognized for update: $fieldName");
    }
  }

  // Clear the driver model instance
  void clear() {
    _driverModel = null;
  }
}
