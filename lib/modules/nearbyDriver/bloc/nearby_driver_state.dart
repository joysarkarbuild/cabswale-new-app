import 'package:equatable/equatable.dart';

sealed class NearbyDriverState extends Equatable {
  const NearbyDriverState();

  @override
  List<Object> get props => [];
}

final class NearbyDriverInitial extends NearbyDriverState {}
