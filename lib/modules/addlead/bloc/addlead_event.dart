import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

sealed class AddleadEvent extends Equatable {
  const AddleadEvent();

  @override
  List<Object> get props => [];
}

final class ChangeLeadTypeEvent extends AddleadEvent {
  final String leadType;

  const ChangeLeadTypeEvent({required this.leadType});
  @override
  List<Object> get props => [leadType];
}

final class UploadLeadEvent extends AddleadEvent {
  final BuildContext context;
  final String pickupLocation;
  final String dropLocation;
  final String vehicle;
  final String extraMessage;
  const UploadLeadEvent({
    required this.context,
    required this.dropLocation,
    required this.extraMessage,
    required this.pickupLocation,
    required this.vehicle,
  });

  @override
  List<Object> get props =>
      [pickupLocation, dropLocation, vehicle, extraMessage];
}
