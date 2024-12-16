import 'package:cabswalle/modules/home/data/models/lead_data_model.dart';
import 'package:equatable/equatable.dart';

sealed class MyleadsState extends Equatable {
  const MyleadsState();

  @override
  List<Object> get props => [];
}

final class MyleadsInitial extends MyleadsState {}

final class MyleadsLoading extends MyleadsState {}

final class MyleadsLoaded extends MyleadsState {
  final List<LeadModel> leads;
  const MyleadsLoaded({required this.leads});
  @override
  List<Object> get props => [leads];
}
