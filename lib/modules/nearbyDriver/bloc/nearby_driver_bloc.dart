import 'package:bloc/bloc.dart';
import 'package:cabswalle/modules/nearbyDriver/bloc/nearby_driver_event.dart';
import 'package:cabswalle/modules/nearbyDriver/bloc/nearby_driver_state.dart';

class NearbyDriverBloc extends Bloc<NearbyDriverEvent, NearbyDriverState> {
  NearbyDriverBloc() : super(NearbyDriverInitial()) {
    on<NearbyDriverEvent>((event, emit) {});
  }
}
