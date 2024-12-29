import 'package:bloc/bloc.dart';
import 'package:cabswalle/modules/nearbyDriver/bloc/nearby_driver_event.dart';
import 'package:cabswalle/modules/nearbyDriver/bloc/nearby_driver_state.dart';
import 'package:cabswalle/modules/nearbyDriver/data/models/nearby_driver_model.dart';
import 'package:cabswalle/services/location_service.dart';
import 'package:cabswalle/services/typesense_service.dart';

class NearbyDriverBloc extends Bloc<NearbyDriverEvent, NearbyDriverState> {
  NearbyDriverBloc() : super(NearbyDriverInitial()) {
    on<NearbyDriverEvent>((event, emit) {});
    TypeSenseInstance typeSenseInstance = TypeSenseInstance();
    LocationService locationService = LocationService();
    on<FetchNearbyDriver>(
      (event, emit) async {
        emit(NearbyDriverLoading());
        try {
          List data = await typeSenseInstance.getNearbyDrivers(
              lat: locationService.currentPosition!.latitude,
              long: locationService.currentPosition!.longitude,
              raduis: 1000);

          List<NearbyDriverModel> nearbyDrivers = data
              .map(
                (e) => NearbyDriverModel.fromJson(e["document"]),
              )
              .toList();

          emit(NearbyDriverLoaded(nearbyDrivers: nearbyDrivers));
        } catch (e) {
          emit(NearbyDriverError(meaasge: e.toString()));
        }
      },
    );
  }
}
