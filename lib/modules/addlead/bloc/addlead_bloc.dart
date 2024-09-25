import 'package:bloc/bloc.dart';
import 'package:cabswalle/modules/addlead/bloc/addlead_event.dart';
import 'package:cabswalle/modules/addlead/bloc/addlead_state.dart';

class AddleadBloc extends Bloc<AddleadEvent, AddleadState> {
  AddleadBloc() : super(AddleadInitial()) {
    on<AddleadEvent>((event, emit) {});
  }
}
