import 'package:cabswalle/modules/myprofile/data/models/user_profile_data_model.dart';
import 'package:equatable/equatable.dart';

sealed class HomeState extends Equatable {
  const HomeState();

  @override
  List<Object> get props => [];
}

final class HomeInitial extends HomeState {}

final class HomeLoadingState extends HomeState {}

final class HomeLoadedState extends HomeState {
  final UserProfileDataModel? userProfile;
  const HomeLoadedState({required this.userProfile});
  @override
  List<Object> get props => [userProfile!];
}

final class HomeErrorState extends HomeState {
  final String errorMessage;
  const HomeErrorState({required this.errorMessage});
  @override
  List<Object> get props => [errorMessage];
}
