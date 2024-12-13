import 'package:bloc/bloc.dart';
import 'package:cabswalle/modules/home/bloc/home_event.dart';
import 'package:cabswalle/modules/home/bloc/home_state.dart';
import 'package:cabswalle/modules/home/data/models/count_data_model.dart';
import 'package:cabswalle/modules/home/data/models/lead_data_model.dart';
import 'package:cabswalle/modules/home/data/models/lead_fetch_result_data_model.dart';
import 'package:cabswalle/modules/home/data/repository/home_data_repository.dart';
import 'package:cabswalle/services/typesense_service.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final HomeDataRepository homeDataRepository = HomeDataRepository();
  HomeBloc() : super(HomeInitial()) {
    on<FetchHomeDataEvent>(
      (event, emit) async {
        try {
          emit(HomeLoadingState());
          CountDataModel countData = await homeDataRepository.fetchCountData();
          LeadFetchResult leads =
              await homeDataRepository.fetchLeads(leadType: "Commission");
          emit(HomeLoadedState(
              countData: countData,
              leads: leads,
              leadType: "commission",
              searchText: "",
              fetchingMore: false,
              leadLoading: false));
        } catch (e) {
          emit(HomeErrorState(errorMessage: e.toString()));
        }
      },
    );

    on<ChangeLeadType>(
      (event, emit) async {
        try {
          emit(HomeLoadedState(
              leadType: event.leadType,
              leads: LeadFetchResult(leads: [], lastDoc: null),
              countData: event.countData,
              searchText: "",
              fetchingMore: false,
              leadLoading: true));
          LeadFetchResult leads = await homeDataRepository.fetchLeads(
              leadType: capitalizeFirstChar(event.leadType));

          emit(HomeLoadedState(
              leadType: event.leadType,
              leads: leads,
              countData: event.countData,
              searchText: "",
              fetchingMore: false,
              leadLoading: false));
        } catch (e) {
          emit(HomeErrorState(errorMessage: e.toString()));
        }
      },
    );

    on<SearchLeads>(
      (event, emit) async {
        try {
          emit(HomeLoadedState(
              leadType: "commission",
              leads: LeadFetchResult(leads: [], lastDoc: null),
              countData: event.countData,
              searchText: event.searcText,
              fetchingMore: false,
              leadLoading: true));
          List<LeadModel> leads =
              await TypeSenseInstance().getSearchedLeadsTS(event.searcText, 1);

          emit(HomeLoadedState(
              leadType: "commission",
              leads: LeadFetchResult(leads: leads, lastDoc: null),
              countData: event.countData,
              searchText: event.searcText,
              fetchingMore: false,
              leadLoading: false));
        } catch (e) {
          emit(HomeErrorState(errorMessage: e.toString()));
        }
      },
    );

    on<FetchMoreLeadsEvent>(
      (event, emit) async {
        if (state is HomeLoadedState) {
          emit(HomeLoadedState(
              leadType: (state as HomeLoadedState).leadType,
              leads: (state as HomeLoadedState).leads,
              countData: (state as HomeLoadedState).countData,
              searchText: (state as HomeLoadedState).searchText,
              fetchingMore: true,
              leadLoading: false));

          LeadFetchResult leads = await homeDataRepository.fetchMoreLeads(
              leadType: capitalizeFirstChar(
                (state as HomeLoadedState).leadType,
              ),
              lastDoc: (state as HomeLoadedState).leads.lastDoc!);
          (state as HomeLoadedState).leads.leads.addAll(leads.leads);
          LeadFetchResult allLead = LeadFetchResult(
              leads: (state as HomeLoadedState).leads.leads,
              lastDoc: leads.lastDoc);

          emit(HomeLoadedState(
              leadType: (state as HomeLoadedState).leadType,
              leads: allLead,
              countData: (state as HomeLoadedState).countData,
              searchText: (state as HomeLoadedState).searchText,
              fetchingMore: false,
              leadLoading: false));
        }
      },
    );
  }

  String capitalizeFirstChar(String input) {
    if (input.isEmpty) return input;
    return input[0].toUpperCase() + input.substring(1);
  }
}
