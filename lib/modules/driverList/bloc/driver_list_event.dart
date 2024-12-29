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
