// splash_state.dart
import 'package:cabswalle/modules/splash/data/models/app_data_model.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

@immutable
sealed class SplashState extends Equatable {
  @override
  List<Object?> get props => [];
}

// Initial state
final class SplashInitial extends SplashState {}

// Loading state
final class SplashLoading extends SplashState {}

// When the app version matches
final class AppVersionMatched extends SplashState {
  final AppDataModel appData;

  AppVersionMatched({required this.appData});
  @override
  List<Object?> get props => [appData];
}

// When the app version is outdated
final class AppVersionOutdated extends SplashState {
  final AppDataModel appData;

  AppVersionOutdated({
    required this.appData,
  });

  // Defining props for comparison
  @override
  List<Object?> get props => [appData];
}

// Error state
final class SplashError extends SplashState {
  final String message;

  SplashError(this.message);

  @override
  List<Object?> get props => [message];
}
