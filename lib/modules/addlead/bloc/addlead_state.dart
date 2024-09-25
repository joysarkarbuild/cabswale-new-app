import 'package:equatable/equatable.dart';

sealed class AddleadState extends Equatable {
  const AddleadState();

  @override
  List<Object> get props => [];
}

final class AddleadInitial extends AddleadState {}
