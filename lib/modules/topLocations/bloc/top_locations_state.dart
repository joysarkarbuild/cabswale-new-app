import 'package:equatable/equatable.dart';

sealed class TopLocationsState extends Equatable {
  const TopLocationsState();

  @override
  List<Object> get props => [];
}

final class TopLocationsInitial extends TopLocationsState {}
