import 'package:bloc/bloc.dart';
import 'package:cabswalle/modules/topLocations/bloc/topLocations_event.dart';
import 'package:cabswalle/modules/topLocations/bloc/topLocations_state.dart';

class TopLocationsBloc extends Bloc<TopLocationsEvent, TopLocationsState> {
  TopLocationsBloc() : super(TopLocationsInitial()) {
    on<TopLocationsEvent>((event, emit) {});
  }
}
