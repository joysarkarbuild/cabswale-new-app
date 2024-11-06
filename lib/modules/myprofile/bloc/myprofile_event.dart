import 'package:cabswalle/modules/myprofile/data/models/user_profile_data_model.dart';
import 'package:equatable/equatable.dart';

sealed class MyprofileEvent extends Equatable {
  const MyprofileEvent();

  @override
  List<Object> get props => [];
}

final class MyProfileLoadEvent extends MyprofileEvent {}

final class UpdateMyProfileEvent extends MyprofileEvent {
  final UserProfileDataModel myProfile;
  const UpdateMyProfileEvent({required this.myProfile});
  @override
  List<Object> get props => [myProfile];
}
