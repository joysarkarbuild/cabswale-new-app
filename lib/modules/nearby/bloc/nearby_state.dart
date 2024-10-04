import 'package:equatable/equatable.dart';

sealed class NearbyState extends Equatable {
  const NearbyState();

  @override
  List<Object> get props => [];
}

final class NearbyInitial extends NearbyState {}
