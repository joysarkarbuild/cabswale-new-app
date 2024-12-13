import 'package:bloc/bloc.dart';
import 'package:cabswalle/modules/otp/bloc/otp_event.dart';
import 'package:cabswalle/modules/otp/bloc/otp_state.dart';

class OtpBloc extends Bloc<OtpEvent, OtpState> {
  OtpBloc() : super(OtpInitial()) {
    on<OtpEvent>((event, emit) {});
  }
}
