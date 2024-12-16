import 'package:equatable/equatable.dart';

sealed class FilterleadsEvent extends Equatable {
  const FilterleadsEvent();

  @override
  List<Object> get props => [];
}

final class FetchLeadInitEvent extends FilterleadsEvent {
  final String city;
  const FetchLeadInitEvent({required this.city});
  @override
  List<Object> get props => [city];
}

final class FetchLeadMoreEvent extends FilterleadsEvent {
  final String city;
  const FetchLeadMoreEvent({required this.city});
  @override
  List<Object> get props => [city];
}

final class FetchLeadInitMyLocationLeadsEvent extends FilterleadsEvent {}

final class FetchLeadMoreMyLocationLeadsEvent extends FilterleadsEvent {}
