import 'package:equatable/equatable.dart';

sealed class EmergencyState extends Equatable {
  const EmergencyState();

  @override
  List<Object> get props => [];
}

final class EmergencyInitial extends EmergencyState {}
