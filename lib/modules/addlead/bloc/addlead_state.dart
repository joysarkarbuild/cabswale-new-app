import 'package:equatable/equatable.dart';

sealed class AddleadState extends Equatable {
  const AddleadState();

  @override
  List<Object> get props => [];
}

final class AddleadInitial extends AddleadState {}

final class ChangeLeadType extends AddleadState {
  final String leadType;
  const ChangeLeadType({required this.leadType});
  @override
  List<Object> get props => [leadType];
}
