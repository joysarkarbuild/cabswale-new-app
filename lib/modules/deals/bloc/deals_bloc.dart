import 'package:bloc/bloc.dart';
import 'package:cabswalle/modules/deals/bloc/deals_event.dart';
import 'package:cabswalle/modules/deals/bloc/deals_state.dart';

class DealsBloc extends Bloc<DealsEvent, DealsState> {
  DealsBloc() : super(DealsInitial()) {
    on<DealsEvent>((event, emit) {});
  }
}
