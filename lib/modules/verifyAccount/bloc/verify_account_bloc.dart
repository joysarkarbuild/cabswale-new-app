import 'package:bloc/bloc.dart';
import 'package:cabswalle/modules/verifyAccount/bloc/verifyAccount_event.dart';
import 'package:cabswalle/modules/verifyAccount/bloc/verifyAccount_state.dart';

class VerifyAccountBloc extends Bloc<VerifyAccountEvent, VerifyAccountState> {
  VerifyAccountBloc() : super(VerifyAccountInitial()) {
    on<VerifyAccountEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
