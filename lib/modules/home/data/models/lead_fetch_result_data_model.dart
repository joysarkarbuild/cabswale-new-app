import 'package:cabswalle/modules/home/data/models/lead_data_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class LeadFetchResult {
  final List<LeadModel> leads;
  final DocumentSnapshot? lastDoc;

  LeadFetchResult({required this.leads, required this.lastDoc});
}
