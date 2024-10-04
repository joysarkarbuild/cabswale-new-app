import 'package:bloc/bloc.dart';
import 'package:cabswalle/modules/nearbyPlace/bloc/nearbyPlace_event.dart';
import 'package:cabswalle/modules/nearbyPlace/bloc/nearbyPlace_state.dart';

class NearbyPlaceBloc extends Bloc<NearbyPlaceEvent, NearbyPlaceState> {
  NearbyPlaceBloc() : super(NearbyPlaceInitial()) {
    on<NearbyPlaceEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
