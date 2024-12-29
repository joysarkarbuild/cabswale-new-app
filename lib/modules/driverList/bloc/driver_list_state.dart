import 'package:cabswalle/modules/nearbyDriver/data/models/nearby_driver_model.dart';
import 'package:equatable/equatable.dart';

sealed class DriverListState extends Equatable {
  const DriverListState();

  @override
  List<Object> get props => [];
}

final class DriverListInitial extends DriverListState {}

final class DriverLoading extends DriverListState {}

final class DriverLoaded extends DriverListState {
  final List<NearbyDriverModel> drivers;
  const DriverLoaded({required this.drivers});
  @override
  List<Object> get props => [drivers];
}

final class DriverError extends DriverListState {}
