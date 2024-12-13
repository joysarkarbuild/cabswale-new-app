import 'package:cabswalle/modules/myprofile/data/models/user_profile_data_model.dart';
import 'package:equatable/equatable.dart';

sealed class MyprofileState extends Equatable {
  const MyprofileState();

  @override
  List<Object> get props => [];
}

final class MyprofileInitial extends MyprofileState {}

final class MyProfileLoading extends MyprofileState {}

final class MyProfileLoaded extends MyprofileState {
  final UserProfileDataModel myProfile;
  const MyProfileLoaded({required this.myProfile});
  @override
  List<Object> get props => [myProfile];
}

final class MyProfileError extends MyprofileState {
  final String errorMessage;
  const MyProfileError({required this.errorMessage});
  @override
  List<Object> get props => [errorMessage];
}
