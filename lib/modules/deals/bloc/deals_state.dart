import 'package:equatable/equatable.dart';

sealed class DealsState extends Equatable {
  const DealsState();

  @override
  List<Object> get props => [];
}

final class DealsInitial extends DealsState {}
