import 'package:cabswalle/modules/myprofile/data/models/user_profile_data_model.dart';
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

final class UpdateNotificationLocationsEvent extends HomeEvent {
  final BuildContext context;
  final List<NotificationLocation> notificationLocations;
  const UpdateNotificationLocationsEvent(
      {required this.context, required this.notificationLocations});

  @override
  List<Object> get props => [notificationLocations];
}

final class UpdateGetDutyAlertEvent extends HomeEvent {
  final BuildContext context;
  final bool isActive;
  const UpdateGetDutyAlertEvent(
      {required this.context, required this.isActive});

  @override
  List<Object> get props => [isActive];
}
