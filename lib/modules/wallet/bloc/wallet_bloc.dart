import 'package:bloc/bloc.dart';
import 'package:cabswalle/modules/wallet/bloc/wallet_event.dart';
import 'package:cabswalle/modules/wallet/bloc/wallet_state.dart';

class WalletBloc extends Bloc<WalletEvent, WalletState> {
  WalletBloc() : super(WalletInitial()) {
    on<WalletEvent>((event, emit) {});
  }
}
