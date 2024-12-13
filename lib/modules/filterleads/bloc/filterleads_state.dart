import 'package:equatable/equatable.dart';

sealed class FilterleadsState extends Equatable {
  const FilterleadsState();

  @override
  List<Object> get props => [];
}

final class FilterleadsInitial extends FilterleadsState {}
