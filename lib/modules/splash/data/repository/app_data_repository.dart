import 'package:cabswalle/modules/splash/data/models/app_data_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AppDataRepository {
  final FirebaseFirestore _firestore;

  AppDataRepository({FirebaseFirestore? firestore})
      : _firestore = firestore ?? FirebaseFirestore.instance;

  Future<AppDataModel> fetchAppVersion() async {
    try {
      DocumentSnapshot documentSnapshot =
          await _firestore.collection('settings').doc('app').get();
      return AppDataModel.fromJson(
          documentSnapshot.data() as Map<String, dynamic>);
    } catch (e) {
      throw Exception('Error fetching app data: $e');
    }
  }
}
