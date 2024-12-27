import 'package:cabswalle/modules/topLocations/topRoutes/data/models/top_routes_model.dart';
import 'package:equatable/equatable.dart';

abstract class TopRoutesState extends Equatable {
  @override
  List<Object?> get props => [];
}

class TopRoutesInitial extends TopRoutesState {}

class TopRoutesLoading extends TopRoutesState {}

class TopRoutesLoaded extends TopRoutesState {
  final List<TopRouteModel> routes;
  final bool hasMore;
  final bool isMoreLoading;

  TopRoutesLoaded(
      {required this.routes,
      required this.hasMore,
      required this.isMoreLoading});

  @override
  List<Object?> get props => [routes, hasMore, isMoreLoading];
}

class TopRoutesError extends TopRoutesState {
  final String message;

  TopRoutesError(this.message);

  @override
  List<Object?> get props => [message];
}
