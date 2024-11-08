import 'package:bloc/bloc.dart';
import 'package:cabswalle/modules/myprofile/bloc/myprofile_bloc.dart';
import 'package:cabswalle/modules/myprofile/bloc/myprofile_event.dart';
import 'package:cabswalle/modules/myprofile/bloc/myprofile_state.dart';
import 'package:cabswalle/modules/verifyAccount/bloc/verify_account_event.dart';
import 'package:cabswalle/modules/verifyAccount/bloc/verify_account_state.dart';
import 'package:cabswalle/modules/verifyAccount/data/repository/update_user_data_repo.dart';
import 'package:cabswalle/services/loading_overlay_service.dart';
import 'package:cabswalle/services/logger_service.dart';
import 'package:cabswalle/services/snackbar_service.dart';
import 'package:go_router/go_router.dart';

class VerifyAccountBloc extends Bloc<VerifyAccountEvent, VerifyAccountState> {
  final MyprofileBloc myprofileBloc;
  VerifyAccountBloc(this.myprofileBloc) : super(VerifyAccountInitial()) {
    UpdateUserDataRepo updateUserDataRepo = UpdateUserDataRepo();
    on<VerifyAccountEvent>((event, emit) {});
    on<SelectProfileImageEvent>(
      (event, emit) {
        emit(SelectProfileImageState(selectedImage: event.selectedImage));
      },
    );

    on<UpdateProfileNameCityImageSubmitEvent>(
      (event, emit) async {
        emit(UpdateProfileLoading());
        LoadingOverlay().show(event.context);
        try {
          Map<String, dynamic> response =
              await updateUserDataRepo.updateUserProfile(
                  name: event.name,
                  city: event.city,
                  exprience: event.exprience,
                  profilePic: event.selectedImage);
          LoggerService.logInfo("Status $response");
          if (response["status"]) {
            LoggerService.logInfo("Complete");
            emit(UpdateProfileCompleteState());
            if (myprofileBloc.state is MyProfileLoaded) {
              final currentProfile =
                  (myprofileBloc.state as MyProfileLoaded).myProfile;

              // Create an updated UserProfileDataModel
              if (response["profileImage"].toString().isNotEmpty) {
                final updatedProfile = currentProfile.copyWith(
                  name: event.name,
                  city: event.city,
                  experience: event.exprience,
                  profileImage: response["profileImage"],
                );
                myprofileBloc
                    .add(UpdateMyProfileEvent(myProfile: updatedProfile));
              } else {
                final updatedProfile = currentProfile.copyWith(
                  name: event.name,
                  city: event.city,
                  experience: event.exprience,
                );
                myprofileBloc
                    .add(UpdateMyProfileEvent(myProfile: updatedProfile));
              }
            }
            // ignore: use_build_context_synchronously
            event.context.pop();
          } else {
            emit(UpdateProfileErrorState());
          }

          LoadingOverlay().hide();
        } catch (e) {
          LoadingOverlay().hide();
          SnackbarUtils.showErrorSnackBar(message: e.toString());
        }
      },
    );

    on<UpdateTopRoutesEvent>(
      (event, emit) async {
        emit(UpdateProfileLoading());
        LoadingOverlay().show(event.context);
        try {
          bool status = await updateUserDataRepo.updateTopRoutes(
              topRoutes: event.topRoutes);
          if (status) {
            LoggerService.logInfo("Complete");
            emit(UpdateProfileCompleteState());
            if (myprofileBloc.state is MyProfileLoaded) {
              final currentProfile =
                  (myprofileBloc.state as MyProfileLoaded).myProfile;
              final updatedProfile =
                  currentProfile.copyWith(routes: event.topRoutes);
              myprofileBloc
                  .add(UpdateMyProfileEvent(myProfile: updatedProfile));
            }
            // ignore: use_build_context_synchronously
            event.context.pop();
          } else {
            emit(UpdateProfileErrorState());
          }

          LoadingOverlay().hide();
        } catch (e) {
          LoadingOverlay().hide();
          SnackbarUtils.showErrorSnackBar(message: e.toString());
        }
      },
    );

    on<UpdateVehiclesEvent>(
      (event, emit) async {
        emit(UpdateProfileLoading());
        LoadingOverlay().show(event.context);
        try {
          bool status =
              await updateUserDataRepo.updateVehicles(vehicles: event.vehicles);
          if (status) {
            LoggerService.logInfo("Complete");
            emit(UpdateProfileCompleteState());
            if (myprofileBloc.state is MyProfileLoaded) {
              final currentProfile =
                  (myprofileBloc.state as MyProfileLoaded).myProfile;
              final updatedProfile =
                  currentProfile.copyWith(vehicles: event.vehicles);
              myprofileBloc
                  .add(UpdateMyProfileEvent(myProfile: updatedProfile));
            }
            // ignore: use_build_context_synchronously
            event.context.pop();
          } else {
            emit(UpdateProfileErrorState());
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
