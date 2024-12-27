import 'package:cabswalle/modules/home/data/models/lead_data_model.dart';
import 'package:cabswalle/services/driver_service.dart';
import 'package:cabswalle/services/firestore_service.dart';
import 'package:cabswalle/services/logger_service.dart';

class AddLeadDataRepository {
  final FirestoreUtils _firestoreUtils;

  AddLeadDataRepository({FirestoreUtils? firestoreUtils})
      : _firestoreUtils = firestoreUtils ?? FirestoreUtils();

  Future<bool> addLead(
      {required String pickupLocation,
      required String dropLocation,
      required String vehicle,
      required String leadType,
      required String extraMessage}) async {
    try {
      Map<String, dynamic> data = {
        "active": true,
        "at": DateTime.now(),
        "carType": vehicle,
        "createdAt": DateTime.now(),
        "from": From(city: pickupLocation).toJson(),
        "to": From(city: dropLocation).toJson(),
        "message": extraMessage,
        "leadType": leadType,
        "metaData": {
          'source': 'user',
        },
        "status": (DriverService.instance.driverModel!.autoApproveLeads)
            ? "approved"
            : "pending",
        "createdBy": CreatedBy(
                name: DriverService.instance.driverModel!.name,
                id: DriverService.instance.driverModel!.id,
                phoneNo: DriverService.instance.driverModel!.phoneNo,
                verified: DriverService.instance.driverModel!.verified)
            .toJson(),
      };

      LoggerService.logInfo("$data");
      _firestoreUtils.addDocument("leads", data);
      return true;
    } catch (e) {
      return false;
    }
  }
}
