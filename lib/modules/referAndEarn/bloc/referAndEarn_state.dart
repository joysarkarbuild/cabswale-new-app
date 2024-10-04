import 'package:equatable/equatable.dart';

sealed class ReferAndEarnState extends Equatable {
  const ReferAndEarnState();

  @override
  List<Object> get props => [];
}

final class ReferAndEarnInitial extends ReferAndEarnState {}
