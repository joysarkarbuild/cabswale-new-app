import 'package:bloc/bloc.dart';
import 'package:cabswalle/modules/location/bloc/location_event.dart';
import 'package:cabswalle/modules/location/bloc/location_state.dart';

class LocationBloc extends Bloc<LocationEvent, LocationState> {
  LocationBloc() : super(LocationInitial()) {
    on<LocationEvent>((event, emit) {});
  }
}
