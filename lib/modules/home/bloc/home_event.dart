import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

sealed class HomeEvent extends Equatable {
  const HomeEvent();

  @override
  List<Object> get props => [];
}

final class FetchHomeDataEvent extends HomeEvent {
  final BuildContext context;
  const FetchHomeDataEvent({required this.context});

  @override
  List<Object> get props => [];
}
