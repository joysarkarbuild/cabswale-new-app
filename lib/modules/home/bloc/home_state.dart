import 'package:cabswalle/models/driver_model.dart';
import 'package:cabswalle/modules/home/data/models/count_data_model.dart';
import 'package:cabswalle/modules/home/data/models/lead_data_model.dart';
import 'package:cabswalle/modules/home/data/models/lead_fetch_result_data_model.dart';
import 'package:equatable/equatable.dart';

sealed class HomeState extends Equatable {
  const HomeState();

  @override
  List<Object> get props => [];
}

final class HomeInitial extends HomeState {}

final class HomeLoadingState extends HomeState {}

final class HomeLoadedState extends HomeState {
  final CountDataModel countData;
  final LeadFetchResult leads;
  final String searchText;
  final String leadType;
  final bool leadLoading;
  final bool fetchingMore;
  final DriverModel? userProfile;

  const HomeLoadedState(
      {required this.countData,
      required this.leads,
      required this.leadType,
      required this.searchText,
      required this.leadLoading,
      required this.fetchingMore,
      required this.userProfile});

  @override
  List<Object> get props => [
        countData,
        leads,
        leadType,
        searchText,
        leadLoading,
        fetchingMore,
        userProfile!,
      ];
}

final class HomeErrorState extends HomeState {
  final String errorMessage;
  const HomeErrorState({required this.errorMessage});
  @override
  List<Object> get props => [errorMessage];
}
