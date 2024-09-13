import 'package:bloc/bloc.dart';
import 'package:cabswalle/modules/splash/bloc/splash_event.dart';
import 'package:cabswalle/modules/splash/bloc/splash_state.dart';
import 'package:cabswalle/modules/splash/data/models/app_data_model.dart';
import 'package:cabswalle/modules/splash/data/repository/app_data_repository.dart'; // Import the model

int appVersion = 27; // Assuming this is the global app version

class SplashBloc extends Bloc<SplashEvent, SplashState> {
  SplashBloc() : super(SplashInitial()) {
    on<CheckAppVersionEvent>(_onCheckAppVersion);
  }

  final AppDataRepository appDataRepository = AppDataRepository();
  // Function to handle version checking
  Future<void> _onCheckAppVersion(
      CheckAppVersionEvent event, Emitter<SplashState> emit) async {
    emit(SplashLoading());

    try {
      // Fetch the latest app version data from the repository
      AppDataModel appData = await appDataRepository.fetchAppVersion();

      // Compare the versions
      if (appVersion >= appData.appVersion) {
        emit(AppVersionMatched());
      } else {
        emit(AppVersionOutdated(
          forceUpdate: appData.forceUpdate,
          playStoreUrl: appData.playStoreUrl,
          appStoreUrl: appData.appStoreUrl,
        ));
      }
    } catch (e) {
      emit(SplashError('Error checking app version: ${e.toString()}'));
    }
  }
}
