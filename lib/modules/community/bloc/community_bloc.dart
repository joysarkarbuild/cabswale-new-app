import 'package:bloc/bloc.dart';
import 'package:cabswalle/modules/community/bloc/community_event.dart';
import 'package:cabswalle/modules/community/bloc/community_state.dart';
import 'package:cabswalle/modules/services/bloc/services_state.dart';
import 'package:cabswalle/services/community_service.dart';
import 'package:cabswalle/services/driver_service.dart';

class CommunityBloc extends Bloc<CommunityEvent, CommunityState> {
  CommunityBloc() : super(CommunityInitial()) {
    on<LoadServicesData>(_onLoadServicesData);
    on<UpdateWalletBalance>(_onUpdateWalletBalance);
  }

  Future<void> _onLoadServicesData(
      LoadServicesData event, Emitter<CommunityState> emit) async {
    emit(CommunityLoading());
    final CommunityService communityService = CommunityService();
    try {
      // Use CommunityService to fetch data
      final community = await communityService.getCommunityData();

      emit(CommunityLoaded(
        community,
        DriverService.instance.driverModel!.wallet != null
            ? DriverService.instance.driverModel!.wallet!.amount.toInt()
            : 0,
      ));
    } catch (e) {
      emit(CommunityError("Failed to load services: ${e.toString()}"));
    }
  }

  void _onUpdateWalletBalance(
      UpdateWalletBalance event, Emitter<CommunityState> emit) {
    if (state is ServicesLoaded) {
      final currentState = state as ServicesLoaded;
      emit(CommunityLoaded(
        currentState.community,
        event.walletBalance,
      ));
    }
  }
}
