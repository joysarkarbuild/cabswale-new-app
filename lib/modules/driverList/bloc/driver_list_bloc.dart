import 'package:bloc/bloc.dart';
import 'package:cabswalle/modules/driverList/bloc/driver_list_event.dart';
import 'package:cabswalle/modules/driverList/bloc/driver_list_state.dart';
import 'package:cabswalle/modules/nearbyDriver/data/models/nearby_driver_model.dart';
import 'package:cabswalle/services/typesense_service.dart';

class DriverListBloc extends Bloc<DriverListEvent, DriverListState> {
  DriverListBloc() : super(DriverListInitial()) {
    TypeSenseInstance typeSenseInstance = TypeSenseInstance();
    on<DriverListEvent>((event, emit) {});
    on<FetchDrivers>(
      (event, emit) async {
        emit(DriverLoading());
        List data = await typeSenseInstance.getVerifiedDrivers(event.type, 1);
        List<NearbyDriverModel> drivers = data
            .map(
              (e) => NearbyDriverModel.fromJson(e["document"]),
            )
            .toList();
        emit(DriverLoaded(drivers: drivers));
      },
    );
  }
}
