import 'package:cabswalle/services/firestore_service.dart';
import 'package:cabswalle/services/login_manager.dart';
import 'package:cabswalle/services/snackbar_service.dart';

class DealsDataRepository {
  final FirestoreUtils firestoreUtils = FirestoreUtils();
  Future<Map<String, dynamic>> getCallAnalytics() async {
    try {
      final analiticsData = await firestoreUtils.getDocument(
          "driverAnalytics", LoginManager.userId!);
      return analiticsData!.data() as Map<String, dynamic>;
    } catch (e) {
      SnackbarUtils.showErrorSnackBar(message: e.toString());
      return {};
    }
  }
}
