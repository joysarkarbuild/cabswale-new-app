import 'package:cabswalle/modules/nearbyDriver/data/models/nearby_driver_model.dart';
import 'package:equatable/equatable.dart';

sealed class NearbyDriverState extends Equatable {
  const NearbyDriverState();

  @override
  List<Object> get props => [];
}

final class NearbyDriverInitial extends NearbyDriverState {}

final class NearbyDriverLoading extends NearbyDriverState {}

final class NearbyDriverLoaded extends NearbyDriverState {
  final List<NearbyDriverModel> nearbyDrivers;

  const NearbyDriverLoaded({required this.nearbyDrivers});
  @override
  List<Object> get props => [nearbyDrivers];
}

final class NearbyDriverError extends NearbyDriverState {
  final String meaasge;
  const NearbyDriverError({required this.meaasge});
  @override
  List<Object> get props => [meaasge];
}
