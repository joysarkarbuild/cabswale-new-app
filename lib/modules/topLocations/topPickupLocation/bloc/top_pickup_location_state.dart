import 'package:cabswalle/modules/topLocations/topPickupLocation/data/models/top_pickup_location_model.dart';
import 'package:equatable/equatable.dart';

abstract class TopPickupLocationState extends Equatable {
  @override
  List<Object?> get props => [];
}

class TopPickupLocationInitial extends TopPickupLocationState {}

class TopPickupLocationLoading extends TopPickupLocationState {}

class TopPickupLocationLoaded extends TopPickupLocationState {
  final List<TopPickupModel> topPickupLocations;
  final bool hasMore;
  final bool isMoreLoading;

  TopPickupLocationLoaded(
      {required this.topPickupLocations,
      required this.hasMore,
      required this.isMoreLoading});

  @override
  List<Object?> get props => [topPickupLocations, hasMore, isMoreLoading];
}

class TopPickupLocationError extends TopPickupLocationState {
  final String message;

  TopPickupLocationError(this.message);

  @override
  List<Object?> get props => [message];
}
