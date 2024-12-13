import 'package:bloc/bloc.dart';
import 'package:cabswalle/modules/extraBenifits/bloc/extra_benifits_event.dart';
import 'package:cabswalle/modules/extraBenifits/bloc/extra_benifits_state.dart';

class ExtraBenifitsBloc extends Bloc<ExtraBenifitsEvent, ExtraBenifitsState> {
  ExtraBenifitsBloc() : super(ExtraBenifitsInitial()) {
    on<ExtraBenifitsEvent>((event, emit) {});
  }
}
