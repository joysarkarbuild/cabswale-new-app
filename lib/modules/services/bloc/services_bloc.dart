import 'package:bloc/bloc.dart';
import 'package:cabswalle/modules/services/bloc/services_event.dart';
import 'package:cabswalle/modules/services/bloc/services_state.dart';
import 'package:cabswalle/services/driver_service.dart';
import 'package:cabswalle/services/community_service.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ServicesBloc extends Bloc<ServicesEvent, ServicesState> {
  ServicesBloc() : super(ServicesInitial()) {
    on<LoadServicesData>(_onLoadServicesData);
    on<UpdateWalletBalance>(_onUpdateWalletBalance);
  }

  Future<void> _onLoadServicesData(
      LoadServicesData event, Emitter<ServicesState> emit) async {
    emit(ServicesLoading());
    final CommunityService communityService = CommunityService();
    try {
      // Use CommunityService to fetch data
      final community = await communityService.getCommunityData();

      emit(ServicesLoaded(
        community,
        DriverService.instance.driverModel!.wallet!.amount.toInt(),
      ));
    } catch (e) {
      emit(ServicesError("Failed to load services: ${e.toString()}"));
    }
  }

  void _onUpdateWalletBalance(
      UpdateWalletBalance event, Emitter<ServicesState> emit) {
    if (state is ServicesLoaded) {
      final currentState = state as ServicesLoaded;
      emit(ServicesLoaded(
        currentState.community,
        event.walletBalance,
      ));
    }
  }
}
