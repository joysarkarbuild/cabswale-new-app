import 'package:equatable/equatable.dart';

sealed class NearbyDriverEvent extends Equatable {
  const NearbyDriverEvent();

  @override
  List<Object> get props => [];
}

final class FetchNearbyDriver extends NearbyDriverEvent {}
