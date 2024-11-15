import 'package:bloc/bloc.dart';
import 'package:cabswalle/modules/community/screen/community_view.dart';
import 'package:cabswalle/modules/home/bloc/home_event.dart';
import 'package:cabswalle/modules/home/bloc/home_state.dart';
import 'package:cabswalle/modules/myprofile/data/models/user_profile_data_model.dart';
import 'package:cabswalle/modules/myprofile/data/repository/profile_data_repo.dart';
import 'package:cabswalle/modules/verifyAccount/data/repository/update_user_data_repo.dart';
import 'package:cabswalle/services/loading_overlay_service.dart';
import 'package:cabswalle/services/login_status_service.dart';
import 'package:cabswalle/services/snackbar_service.dart';
import 'package:go_router/go_router.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  HomeBloc() : super(HomeInitial()) {
    MyProfileDataRepo myProfileDataRepo = MyProfileDataRepo();
    UpdateUserDataRepo updateUserDataRepo = UpdateUserDataRepo();
    on<HomeEvent>((event, emit) {});
    on<FetchHomeDataEvent>(
      (event, emit) async {
        emit(HomeLoadingState());
        try {
          if (LoginManager.isLogin) {
            UserProfileDataModel userProfile =
                await myProfileDataRepo.fetchMyProfileData();
            emit(HomeLoadedState(userProfile: userProfile));
          } else {
            emit(HomeLoadedState(userProfile: null));
          }
        } catch (e) {
          emit(HomeErrorState(errorMessage: e.toString()));
        }
      },
    );

    on<UpdateNotificationLocationsEvent>(
      (event, emit) async {
        try {
          LoadingOverlay().show(event.context);
          bool status = await updateUserDataRepo.updateNotificationLocations(
              notificationLocations: event.notificationLocations);
          if (status && (state is HomeLoadedState)) {
            final currentProfile = (state as HomeLoadedState)
                .userProfile
                ?.copyWith(notificationLocations: event.notificationLocations);
            emit(HomeLoadedState(userProfile: currentProfile));
          }

          LoadingOverlay().hide();
          // ignore: use_build_context_synchronously
          event.context.pop();
          if (event.notificationLocations.isNotEmpty) {
            SnackbarUtils.showSuccessSnackBar(
                message: "You will be notified for ${[
              ...event.notificationLocations.map(
                (e) => e.location,
              )
            ]}");
          } else {
            SnackbarUtils.showSuccessSnackBar(
                message: "Notification Locations Cleared!");
          }
        } catch (e) {
          LoadingOverlay().hide();
          SnackbarUtils.showErrorSnackBar(message: e.toString());
        }
      },
    );

    on<UpdateGetDutyAlertEvent>(
      (event, emit) async {
        try {
          LoadingOverlay().show(event.context);
          bool status = await updateUserDataRepo.updateGetDutyAlerts(
              getDutyAlerts: event.isActive);
          if (status && (state is HomeLoadedState)) {
            final currentProfile = (state as HomeLoadedState)
                .userProfile
                ?.copyWith(getDutyAlerts: event.isActive);
            emit(HomeLoadedState(userProfile: currentProfile));
          }

          LoadingOverlay().hide();
        } catch (e) {
          LoadingOverlay().hide();
          SnackbarUtils.showErrorSnackBar(message: e.toString());
        }
      },
    );
  }
}
