import 'package:bloc/bloc.dart';
import 'package:cabswalle/modules/referAndEarn/bloc/refer_and_earn_event.dart';
import 'package:cabswalle/modules/referAndEarn/bloc/refer_and_earn_state.dart';

class ReferAndEarnBloc extends Bloc<ReferAndEarnEvent, ReferAndEarnState> {
  ReferAndEarnBloc() : super(ReferAndEarnInitial()) {
    on<ReferAndEarnEvent>((event, emit) {});
  }
}
