import 'package:bloc/bloc.dart';
import 'package:cabswalle/modules/verifyAccount/bloc/verify_account_event.dart';
import 'package:cabswalle/modules/verifyAccount/bloc/verify_account_state.dart';

class VerifyAccountBloc extends Bloc<VerifyAccountEvent, VerifyAccountState> {
  VerifyAccountBloc() : super(VerifyAccountInitial()) {
    on<VerifyAccountEvent>((event, emit) {});
  }
}
