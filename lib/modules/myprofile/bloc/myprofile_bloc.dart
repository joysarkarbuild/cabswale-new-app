import 'package:bloc/bloc.dart';
import 'package:cabswalle/modules/myprofile/bloc/myprofile_event.dart';
import 'package:cabswalle/modules/myprofile/bloc/myprofile_state.dart';
import 'package:cabswalle/modules/myprofile/data/models/user_profile_data_model.dart';
import 'package:cabswalle/modules/myprofile/data/repository/profile_data_repo.dart';
import 'package:cabswalle/services/login_manager.dart';

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
      MyProfileLoadEvent event, Emitter<MyprofileState> emit) async {
    emit(MyProfileLoading());
    MyProfileDataRepo userProfileDataRepo = MyProfileDataRepo();
    try {
      if (event.userId.isNotEmpty) {
        UserProfileDataModel userProfileData =
            await userProfileDataRepo.fetchMyProfileData(userId: event.userId);
        emit(MyProfileLoaded(myProfile: userProfileData));
      } else {
        UserProfileDataModel userProfileData = await userProfileDataRepo
            .fetchMyProfileData(userId: LoginManager.userId!);
        emit(MyProfileLoaded(myProfile: userProfileData));
      }
    } catch (e) {
      emit(MyProfileError(errorMessage: e.toString()));
    }
  }
}
