import 'package:bloc/bloc.dart';
import 'package:cabswalle/modules/partnerWithUs/bloc/partnerWithUs_event.dart';
import 'package:cabswalle/modules/partnerWithUs/bloc/partnerWithUs_state.dart';

class PartnerWithUsBloc extends Bloc<PartnerWithUsEvent, PartnerWithUsState> {
  PartnerWithUsBloc() : super(PartnerWithUsInitial()) {
    on<PartnerWithUsEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
