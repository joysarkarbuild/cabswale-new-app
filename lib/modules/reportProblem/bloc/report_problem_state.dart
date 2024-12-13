import 'package:equatable/equatable.dart';

sealed class ReportProblemState extends Equatable {
  const ReportProblemState();

  @override
  List<Object> get props => [];
}

final class ReportProblemInitial extends ReportProblemState {}
