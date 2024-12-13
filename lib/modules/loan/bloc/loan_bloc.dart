import 'package:bloc/bloc.dart';
import 'package:cabswalle/modules/loan/bloc/loan_event.dart';
import 'package:cabswalle/modules/loan/bloc/loan_state.dart';

class LoanBloc extends Bloc<LoanEvent, LoanState> {
  LoanBloc() : super(LoanInitial()) {
    on<LoanEvent>((event, emit) {});
  }
}
