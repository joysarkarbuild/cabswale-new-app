import 'package:equatable/equatable.dart';

sealed class ExtraBenifitsState extends Equatable {
  const ExtraBenifitsState();

  @override
  List<Object> get props => [];
}

final class ExtraBenifitsInitial extends ExtraBenifitsState {}
