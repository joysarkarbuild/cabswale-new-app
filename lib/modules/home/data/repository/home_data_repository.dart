import 'package:cabswalle/modules/home/data/models/count_data_model.dart';
import 'package:cabswalle/modules/home/data/models/lead_data_model.dart';
import 'package:cabswalle/modules/home/data/models/lead_fetch_result_data_model.dart';

import 'package:cabswalle/services/firestore_service.dart';
import 'package:cabswalle/services/logger_service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:intl/intl.dart'; // Import your ApiService

class HomeDataRepository {
  final FirestoreUtils _firestoreService;

  HomeDataRepository({FirestoreUtils? apiService})
      : _firestoreService = apiService ?? FirestoreUtils();

  Future<CountDataModel> fetchCountData() async {
    try {
      final formattedDate =
          DateFormat('EEE MMM dd yyyy').format(DateTime.now());
      final response = await _firestoreService.getDocumentCollectionDoc(
          "analytics", "count", "dates", formattedDate);

      if (response != null && response.exists) {
        return CountDataModel.fromJson(response.data() as Map<String, dynamic>);
      } else {
        throw Exception('Failed to fetch app data.');
      }
    } catch (e) {
      // Handle any other errors
      throw Exception('Unexpected error fetching app data: $e');
    }
  }

  Future<void> uploadDeviceToken(List availbleTokens) async {
    // Initialize the FirebaseMessaging instance
    FirebaseMessaging messaging = FirebaseMessaging.instance;
    // Request permission for notifications
    NotificationSettings settings = await messaging.requestPermission(
      alert: true,
      badge: true,
      sound: true,
    );
    // Check if permission is granted
    if (settings.authorizationStatus == AuthorizationStatus.authorized) {
      // Permission granted, retrieve the device token
      String? token = await messaging.getToken();
      LoggerService.logInfo("Device Token : $token");
      if (!availbleTokens.contains(token)) {
        List tokens = [];
        tokens.addAll(availbleTokens);
        tokens.add(token);
        await FirebaseFirestore.instance
            .collection('drivers')
            .doc(FirebaseAuth.instance.currentUser!.uid)
            .update(
          {'deviceTokens': tokens},
        );
      }
    }
  }

  Future<LeadFetchResult> fetchLeads({required String leadType}) async {
    try {
      List<LeadModel> fetchedData = [];
      DocumentSnapshot? lastDoc;

      final querySnapshot = await FirebaseFirestore.instance
          .collection('leads')
          .where('leadType', isEqualTo: leadType)
          .where('status', whereIn: ['approved', 'booked'])
          .orderBy('createdAt', descending: true)
          .limit(20)
          .get();

      for (var item in querySnapshot.docs) {
        fetchedData.add(LeadModel.fromJson({"id": item.id, ...item.data()}));
      }

      if (querySnapshot.docs.isNotEmpty) {
        lastDoc = querySnapshot.docs.last; // Set the last document
      }

      return LeadFetchResult(leads: fetchedData, lastDoc: lastDoc);
    } catch (e) {
      throw Exception('Unexpected error fetching app data: $e');
    }
  }

  Future<LeadFetchResult> fetchMoreLeads(
      {required String leadType, required DocumentSnapshot lastDoc}) async {
    try {
      List<LeadModel> fetchedData = [];
      DocumentSnapshot? newLastDoc;

      final querySnapshot = await FirebaseFirestore.instance
          .collection('leads')
          .where('leadType', isEqualTo: leadType)
          .where('status', whereIn: ['approved', 'booked'])
          .orderBy('createdAt', descending: true)
          .limit(20)
          .startAfterDocument(lastDoc)
          .get();

      for (var item in querySnapshot.docs) {
        fetchedData.add(LeadModel.fromJson({"id": item.id, ...item.data()}));
      }

      if (querySnapshot.docs.isNotEmpty) {
        newLastDoc = querySnapshot.docs.last; // Update the last document
      }

      return LeadFetchResult(leads: fetchedData, lastDoc: newLastDoc);
    } catch (e) {
      throw Exception('Unexpected error fetching app data: $e');
    }
  }
}
