import 'package:equatable/equatable.dart';

sealed class VerifyAccountState extends Equatable {
  const VerifyAccountState();

  @override
  List<Object> get props => [];
}

final class VerifyAccountInitial extends VerifyAccountState {}
