import 'package:bloc/bloc.dart';
import 'package:cabswalle/modules/emergency/bloc/emergency_event.dart';
import 'package:cabswalle/modules/emergency/bloc/emergency_state.dart';

class EmergencyBloc extends Bloc<EmergencyEvent, EmergencyState> {
  EmergencyBloc() : super(EmergencyInitial()) {
    on<EmergencyEvent>((event, emit) {});
  }
}
