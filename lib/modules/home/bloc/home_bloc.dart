import 'package:bloc/bloc.dart';
import 'package:cabswalle/modules/home/bloc/home_event.dart';
import 'package:cabswalle/modules/home/bloc/home_state.dart';
import 'package:cabswalle/modules/myprofile/data/models/user_profile_data_model.dart';
import 'package:cabswalle/modules/myprofile/data/repository/profile_data_repo.dart';
import 'package:cabswalle/services/login_status_service.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  HomeBloc() : super(HomeInitial()) {
    MyProfileDataRepo myProfileDataRepo = MyProfileDataRepo();
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
  }
}
