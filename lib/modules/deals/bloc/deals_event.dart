import 'package:equatable/equatable.dart';

sealed class DealsEvent extends Equatable {
  const DealsEvent();

  @override
  List<Object> get props => [];
}

final class FetchDealsData extends DealsEvent {}
