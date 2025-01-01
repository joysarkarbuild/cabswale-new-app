import 'package:equatable/equatable.dart';

sealed class DriverListEvent extends Equatable {
  const DriverListEvent();

  @override
  List<Object> get props => [];
}

final class FetchDrivers extends DriverListEvent {
  final String type;

  const FetchDrivers({required this.type});
  @override
  List<Object> get props => [type];
}

final class GetSearchedDriver extends DriverListEvent {
  final String query;

  const GetSearchedDriver({required this.query});
  @override
  List<Object> get props => [query];
}
