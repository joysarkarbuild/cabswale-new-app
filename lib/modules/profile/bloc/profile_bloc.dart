import 'package:bloc/bloc.dart';
import 'package:cabswalle/modules/profile/bloc/profile_event.dart';
import 'package:cabswalle/modules/profile/bloc/profile_state.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  ProfileBloc() : super(ProfileInitial()) {
    on<ProfileEvent>((event, emit) {});
  }
}
