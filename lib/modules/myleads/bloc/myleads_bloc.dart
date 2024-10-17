import 'package:bloc/bloc.dart';
import 'package:cabswalle/modules/myleads/bloc/myleads_event.dart';
import 'package:cabswalle/modules/myleads/bloc/myleads_state.dart';

class MyleadsBloc extends Bloc<MyleadsEvent, MyleadsState> {
  MyleadsBloc() : super(MyleadsInitial()) {
    on<MyleadsEvent>((event, emit) {});
  }
}
