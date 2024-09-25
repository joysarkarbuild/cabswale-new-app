import 'package:equatable/equatable.dart';

sealed class MyleadsState extends Equatable {
  const MyleadsState();

  @override
  List<Object> get props => [];
}

final class MyleadsInitial extends MyleadsState {}
