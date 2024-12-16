import 'package:cabswalle/modules/home/data/models/lead_data_model.dart';
import 'package:equatable/equatable.dart';

sealed class FilterleadsState extends Equatable {
  const FilterleadsState();

  @override
  List<Object> get props => [];
}

final class FilterleadsInitial extends FilterleadsState {}

final class FilterLeadLoading extends FilterleadsState {}

final class FilterLeadLoaded extends FilterleadsState {
  final List<LeadModel> leads;
  const FilterLeadLoaded({required this.leads});

  @override
  List<Object> get props => [leads];
}
