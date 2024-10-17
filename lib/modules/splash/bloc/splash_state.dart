// splash_state.dart
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
  final String privacyUrl;

  AppVersionMatched({required this.privacyUrl});
  @override
  List<Object?> get props => [privacyUrl];
}

// When the app version is outdated
final class AppVersionOutdated extends SplashState {
  final bool forceUpdate;
  final String playStoreUrl;
  final String appStoreUrl;

  AppVersionOutdated({
    required this.forceUpdate,
    required this.playStoreUrl,
    required this.appStoreUrl,
  });

  // Defining props for comparison
  @override
  List<Object?> get props => [forceUpdate, playStoreUrl, appStoreUrl];
}

// Error state
final class SplashError extends SplashState {
  final String message;

  SplashError(this.message);

  @override
  List<Object?> get props => [message];
}
