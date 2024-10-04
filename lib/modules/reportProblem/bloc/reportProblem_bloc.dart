import 'package:bloc/bloc.dart';
import 'package:cabswalle/modules/reportProblem/bloc/reportProblem_event.dart';
import 'package:cabswalle/modules/reportProblem/bloc/reportProblem_state.dart';

class ReportProblemBloc extends Bloc<ReportProblemEvent, ReportProblemState> {
  ReportProblemBloc() : super(ReportProblemInitial()) {
    on<ReportProblemEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
