import 'package:equatable/equatable.dart';

sealed class NearbyPlaceState extends Equatable {
  const NearbyPlaceState();

  @override
  List<Object> get props => [];
}

final class NearbyPlaceInitial extends NearbyPlaceState {}
