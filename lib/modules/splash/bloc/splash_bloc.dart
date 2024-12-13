import 'dart:io';
import 'package:bloc/bloc.dart';
import 'package:cabswalle/app.dart';
import 'package:cabswalle/modules/splash/bloc/splash_event.dart';
import 'package:cabswalle/modules/splash/bloc/splash_state.dart';
import 'package:cabswalle/modules/splash/data/models/app_data_model.dart';
import 'package:cabswalle/modules/splash/data/repository/app_data_repository.dart';
import 'package:cabswalle/services/logger_service.dart';
import 'package:cabswalle/services/login_manager.dart';
import 'package:url_launcher/url_launcher.dart'; // Import the model

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
      //Get login status from local

      LoginManager().getAllData();
      // Fetch the latest app version data from the repository

      AppDataModel appData = await appDataRepository.fetchAppVersion();
      LoggerService.logInfo("App Version : ${appData.appVersion.toString()}");
      // Compare the versions
      if (Platform.isAndroid) {
        if (appVersion >= appData.appVersion) {
          emit(AppVersionMatched(appData: appData));
        } else {
          emit(AppVersionOutdated(
            appData: appData,
          ));
          final Uri url = Uri.parse(appData.playStoreUrl);
          if (await canLaunchUrl(url)) {
            await launchUrl(url);
          } else {
            emit(SplashError('Something wrong in url'));
          }
        }
      } else if (Platform.isIOS) {
        if (iosAppVersion >= appData.iosVersion) {
          emit(AppVersionMatched(appData: appData));
        } else {
          emit(AppVersionOutdated(
            appData: appData,
          ));
          final Uri url = Uri.parse(appData.appStoreUrl);
          if (await canLaunchUrl(url)) {
            await launchUrl(url);
          } else {
            emit(SplashError('Something wrong in url'));
          }
        }
      }
    } catch (e) {
      emit(SplashError('Error checking app version: ${e.toString()}'));
    }
  }
}
