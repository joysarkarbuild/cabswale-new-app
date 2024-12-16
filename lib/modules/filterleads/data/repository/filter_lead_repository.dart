import 'package:cabswalle/modules/home/data/models/lead_data_model.dart';
import 'package:cabswalle/services/location_service.dart';
import 'package:cabswalle/services/typesense_service.dart';

class FilterLeadRepository {
  final TypeSenseInstance typeSenseInstance = TypeSenseInstance();
  Future<List<LeadModel>> getCityLeads(String city) async {
    List<LeadModel> data = await typeSenseInstance.getSearchedLeadsTS(city, 1);
    return data;
  }

  Future<List<LeadModel>> getCurrentLocationLeads() async {
    LocationService locationService = LocationService();
    if (locationService.currentPosition == null) {
      await locationService.getCurrentPosition();
    }
    List<LeadModel> data = await typeSenseInstance.getMyLocationLeads(
        locationService.currentPosition!, 1);
    return data;
  }
}
