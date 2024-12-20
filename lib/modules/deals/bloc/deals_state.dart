import 'package:equatable/equatable.dart';

sealed class DealsState extends Equatable {
  const DealsState();

  @override
  List<Object> get props => [];
}

final class DealsInitial extends DealsState {}

final class DealsLoading extends DealsState {}

final class DealsLoaded extends DealsState {
  final Map<String, dynamic> data;
  const DealsLoaded({required this.data});

  @override
  List<Object> get props => [data];
}
