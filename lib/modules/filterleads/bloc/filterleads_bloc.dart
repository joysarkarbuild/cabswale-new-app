import 'package:bloc/bloc.dart';
import 'package:cabswalle/modules/filterleads/bloc/filterleads_event.dart';
import 'package:cabswalle/modules/filterleads/bloc/filterleads_state.dart';
import 'package:cabswalle/modules/filterleads/data/repository/filter_lead_repository.dart';
import 'package:cabswalle/modules/home/data/models/lead_data_model.dart';

class FilterleadsBloc extends Bloc<FilterleadsEvent, FilterleadsState> {
  FilterleadsBloc() : super(FilterleadsInitial()) {
    final FilterLeadRepository filterLeadRepository = FilterLeadRepository();
    on<FilterleadsEvent>((event, emit) {});

    on<FetchLeadInitEvent>(
      (event, emit) async {
        emit(FilterLeadLoading());
        List<LeadModel> leads =
            await filterLeadRepository.getCityLeads(event.city);

        emit(FilterLeadLoaded(leads: leads));
      },
    );

    on<FetchLeadMoreEvent>(
      (event, emit) async {
        List<LeadModel> leads =
            await filterLeadRepository.getCityLeads(event.city);

        emit(FilterLeadLoaded(leads: leads));
      },
    );

    on<FetchLeadInitMyLocationLeadsEvent>(
      (event, emit) async {
        emit(FilterLeadLoading());
        List<LeadModel> leads =
            await filterLeadRepository.getCurrentLocationLeads();

        emit(FilterLeadLoaded(leads: leads));
      },
    );

    on<FetchLeadMoreMyLocationLeadsEvent>(
      (event, emit) async {
        List<LeadModel> leads =
            await filterLeadRepository.getCurrentLocationLeads();

        emit(FilterLeadLoaded(leads: leads));
      },
    );
  }
}
