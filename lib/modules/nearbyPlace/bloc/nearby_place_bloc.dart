import 'package:bloc/bloc.dart';
import 'package:cabswalle/modules/nearbyPlace/bloc/nearby_place_event.dart';
import 'package:cabswalle/modules/nearbyPlace/bloc/nearby_place_state.dart';

class NearbyPlaceBloc extends Bloc<NearbyPlaceEvent, NearbyPlaceState> {
  NearbyPlaceBloc() : super(NearbyPlaceInitial()) {
    on<NearbyPlaceEvent>((event, emit) {});
  }
}
