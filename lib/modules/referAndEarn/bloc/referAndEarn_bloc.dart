import 'package:bloc/bloc.dart';
import 'package:cabswalle/modules/referAndEarn/bloc/referAndEarn_event.dart';
import 'package:cabswalle/modules/referAndEarn/bloc/referAndEarn_state.dart';

class ReferAndEarnBloc extends Bloc<ReferAndEarnEvent, ReferAndEarnState> {
  ReferAndEarnBloc() : super(ReferAndEarnInitial()) {
    on<ReferAndEarnEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
