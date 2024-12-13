import 'package:cabswalle/constants/url_constants.dart';
import 'package:cabswalle/services/api_service.dart';

class AddLeadDataRepository {
  final ApiService _apiService;

  AddLeadDataRepository({ApiService? apiService})
      : _apiService = apiService ?? ApiService();

  Future<bool> addLead(
      {required String pickupLocation,
      required String dropLocation,
      required String vehicle,
      required String leadType,
      required Map<String, dynamic> createdBy,
      required String extraMessage}) async {
    var response = await _apiService.post(ApiUrls.addLead, data: {
      "active": true,
      "carType": vehicle,
      "leadType": leadType,
      "metadata": {"source": "user"},
      "from": {"city": pickupLocation},
      "to": {"city": dropLocation},
      "status": "pending",
      "verified": false,
      "createdBy": createdBy,
      "createdAt": DateTime.now().toIso8601String(),
      "updatedAt": DateTime.now().toIso8601String(),
    });
    if (response != null &&
        response.statusCode == 200 &&
        response.data["status"]) {
      return true;
    } else {
      return false;
    }
  }
}
