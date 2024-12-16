import 'package:bloc/bloc.dart';
import 'package:cabswalle/modules/home/data/models/lead_data_model.dart';
import 'package:cabswalle/modules/myleads/bloc/myleads_event.dart';
import 'package:cabswalle/modules/myleads/bloc/myleads_state.dart';
import 'package:cabswalle/modules/myleads/data/repository/my_lead_data_repository.dart';

class MyleadsBloc extends Bloc<MyleadsEvent, MyleadsState> {
  MyleadsBloc() : super(MyleadsInitial()) {
    final MyLeadDataRepository myLeadDataRepository = MyLeadDataRepository();
    on<FetchMyLeads>((event, emit) async {
      emit(MyleadsLoading());
      List<LeadModel> leads = await myLeadDataRepository.getMyLeads();
      emit(MyleadsLoaded(leads: leads));
    });
  }
}
