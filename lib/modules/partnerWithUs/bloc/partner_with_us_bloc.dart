import 'package:bloc/bloc.dart';
import 'package:cabswalle/modules/partnerWithUs/bloc/partner_with_us_event.dart';
import 'package:cabswalle/modules/partnerWithUs/bloc/partner_with_us_state.dart';

class PartnerWithUsBloc extends Bloc<PartnerWithUsEvent, PartnerWithUsState> {
  PartnerWithUsBloc() : super(PartnerWithUsInitial()) {
    on<PartnerWithUsEvent>((event, emit) {});
  }
}
