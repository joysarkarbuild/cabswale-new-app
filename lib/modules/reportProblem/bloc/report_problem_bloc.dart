import 'package:bloc/bloc.dart';
import 'package:cabswalle/modules/reportProblem/bloc/report_problem_event.dart';
import 'package:cabswalle/modules/reportProblem/bloc/report_problem_state.dart';

class ReportProblemBloc extends Bloc<ReportProblemEvent, ReportProblemState> {
  ReportProblemBloc() : super(ReportProblemInitial()) {
    on<ReportProblemEvent>((event, emit) {});
  }
}
