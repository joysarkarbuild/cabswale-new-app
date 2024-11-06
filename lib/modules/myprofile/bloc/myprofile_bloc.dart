import 'package:bloc/bloc.dart';
import 'package:cabswalle/modules/myprofile/bloc/myprofile_event.dart';
import 'package:cabswalle/modules/myprofile/bloc/myprofile_state.dart';
import 'package:cabswalle/modules/myprofile/data/models/user_profile_data_model.dart';
import 'package:cabswalle/modules/myprofile/data/repository/profile_data_repo.dart';

class MyprofileBloc extends Bloc<MyprofileEvent, MyprofileState> {
  MyprofileBloc() : super(MyprofileInitial()) {
    on<MyProfileLoadEvent>(_onGetMyProfileData);
    on<UpdateMyProfileEvent>(
      (event, emit) {
        emit(MyProfileLoaded(myProfile: event.myProfile));
      },
    );
  }

  Future<void> _onGetMyProfileData(
      MyprofileEvent event, Emitter<MyprofileState> emit) async {
    emit(MyProfileLoading());
    MyProfileDataRepo userProfileDataRepo = MyProfileDataRepo();
    try {
      UserProfileDataModel userProfileData =
          await userProfileDataRepo.fetchMyProfileData();
      emit(MyProfileLoaded(myProfile: userProfileData));
    } catch (e) {
      emit(MyProfileError(errorMessage: e.toString()));
    }
  }
}
