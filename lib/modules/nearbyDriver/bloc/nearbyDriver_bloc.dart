import 'package:bloc/bloc.dart';
import 'package:cabswalle/modules/nearbyDriver/bloc/nearbyDriver_event.dart';
import 'package:cabswalle/modules/nearbyDriver/bloc/nearbyDriver_state.dart';

class NearbyDriverBloc extends Bloc<NearbyDriverEvent, NearbyDriverState> {
  NearbyDriverBloc() : super(NearbyDriverInitial()) {
    on<NearbyDriverEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
