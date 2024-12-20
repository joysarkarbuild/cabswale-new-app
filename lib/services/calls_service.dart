import 'package:cabswalle/services/logger_service.dart';
import 'package:cabswalle/services/snackbar_service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class CallsService {
  DocumentSnapshot? lastDocument;
  List<Map<String, dynamic>> allCallList = [];
  bool isLoading = false;
  bool fetchingMoreLeadsLoader = false;
  bool hasMoreData = true; // Tracks if more data is available

  Future<void> getCallHistory({bool refresh = false}) async {
    String uid = FirebaseAuth.instance.currentUser!.uid;

    if (refresh) {
      // Reset states on refresh
      lastDocument = null;
      hasMoreData = true;
      allCallList.clear();
    }

    // Exit early if there is no more data to fetch
    if (!hasMoreData && !refresh) {
      LoggerService.logInfo('No more data to fetch.');
      return;
    }

    try {
      if (lastDocument == null) {
        isLoading = true;
        LoggerService.logInfo('Fetching initial batch of call records...');
        var querySnapshot = await FirebaseFirestore.instance
            .collection('drivers')
            .doc(uid)
            .collection('callRecords')
            .orderBy('createdAt', descending: true)
            .limit(5)
            .get();

        for (var doc in querySnapshot.docs) {
          allCallList.add(doc.data());
        }

        lastDocument =
            querySnapshot.docs.isNotEmpty ? querySnapshot.docs.last : null;
        hasMoreData = querySnapshot.docs.isNotEmpty;
        isLoading = false;
      } else {
        if (fetchingMoreLeadsLoader) return;

        fetchingMoreLeadsLoader = true;
        LoggerService.logInfo('Fetching additional call records...');

        var querySnapshot = await FirebaseFirestore.instance
            .collection('drivers')
            .doc(uid)
            .collection('callRecords')
            .orderBy('createdAt', descending: true)
            .startAfterDocument(lastDocument!)
            .limit(5)
            .get();

        for (var doc in querySnapshot.docs) {
          allCallList.add(doc.data());
        }

        lastDocument =
            querySnapshot.docs.isNotEmpty ? querySnapshot.docs.last : null;
        hasMoreData = querySnapshot.docs.isNotEmpty;
        fetchingMoreLeadsLoader = false;

        if (!hasMoreData) {
          LoggerService.logInfo('All call records have been loaded.');
        }
      }
    } catch (e) {
      SnackbarUtils.showErrorSnackBar(
          message: 'Failed to fetch call records: $e');
      LoggerService.logError('Error fetching data: $e');
      isLoading = false;
      fetchingMoreLeadsLoader = false;
    }
  }
}
