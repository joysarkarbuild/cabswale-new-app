import 'package:bloc/bloc.dart';
import 'package:cabswalle/modules/filterleads/bloc/filterleads_event.dart';
import 'package:cabswalle/modules/filterleads/bloc/filterleads_state.dart';

class FilterleadsBloc extends Bloc<FilterleadsEvent, FilterleadsState> {
  FilterleadsBloc() : super(FilterleadsInitial()) {
    on<FilterleadsEvent>((event, emit) {});
  }
}
