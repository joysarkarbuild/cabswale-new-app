import 'package:cabswalle/modules/home/data/models/lead_data_model.dart';
import 'package:cabswalle/services/logger_service.dart';
import 'package:cabswalle/services/login_manager.dart';
import 'package:cabswalle/services/snackbar_service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class MyLeadDataRepository {
  Future<List<LeadModel>> getMyLeads() async {
    List<LeadModel> fetchedData = [];
    try {
      LoggerService.logInfo("Fetching My Leads");
      await FirebaseFirestore.instance
          .collection('leads')
          .where('createdBy.id', isEqualTo: LoginManager.userId)
          .orderBy('createdAt', descending: true)
          .get()
          .then((value) {
        for (var item in value.docs) {
          fetchedData.add(LeadModel.fromJson({"id": item.id, ...item.data()}));
        }
      });
      return fetchedData;
    } catch (e) {
      SnackbarUtils.showErrorSnackBar(message: e.toString());
      return fetchedData;
    }
  }
}
