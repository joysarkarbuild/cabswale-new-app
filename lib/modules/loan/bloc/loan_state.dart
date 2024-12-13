import 'package:equatable/equatable.dart';

sealed class LoanState extends Equatable {
  const LoanState();

  @override
  List<Object> get props => [];
}

final class LoanInitial extends LoanState {}
