// splash_event.dart
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

@immutable
sealed class SplashEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

// Event for checking the app version
final class CheckAppVersionEvent extends SplashEvent {}
