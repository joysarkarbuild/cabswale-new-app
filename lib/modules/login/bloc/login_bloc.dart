import 'package:bloc/bloc.dart';
import 'package:cabswalle/modules/login/bloc/login_event.dart';
import 'package:cabswalle/modules/login/bloc/login_state.dart';
import 'package:cabswalle/services/login_manager.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  LoginBloc() : super(LoginInitial()) {
    final LoginManager loginManager = LoginManager();
    on<LoginEvent>((event, emit) {});

    on<LoginClickEvent>(
      (event, emit) async {
        await loginManager.sendOtp(
            phoneNumber: event.phoneNo,
            onCodeSent: event.onCodeSent,
            context: event.context,
            onError: event.onError);
        emit(CodeSentState());
      },
    );

    on<StartVerificationEvent>(
      (event, emit) {
        emit(LoginLoadingState());
      },
    );
  }
}
