import 'package:bloc/bloc.dart';
import 'package:cabswalle/modules/nearby/bloc/nearby_event.dart';
import 'package:cabswalle/modules/nearby/bloc/nearby_state.dart';

class NearbyBloc extends Bloc<NearbyEvent, NearbyState> {
  NearbyBloc() : super(NearbyInitial()) {
    on<NearbyEvent>((event, emit) {});
  }
}
