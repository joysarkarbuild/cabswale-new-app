import 'dart:io';

import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

sealed class VerifyAccountEvent extends Equatable {
  const VerifyAccountEvent();

  @override
  List<Object> get props => [];
}

final class SelectProfileImageEvent extends VerifyAccountEvent {
  final File selectedImage;

  const SelectProfileImageEvent({required this.selectedImage});
  @override
  List<Object> get props => [selectedImage];
}

final class UpdateProfileNameCityImageSubmitEvent extends VerifyAccountEvent {
  final File? selectedImage;
  final String name;
  final String city;
  final int exprience;
  final BuildContext context;

  const UpdateProfileNameCityImageSubmitEvent({
    this.selectedImage,
    required this.name,
    required this.city,
    required this.exprience,
    required this.context,
  });
  @override
  List<Object> get props => [name, city, exprience];
}

final class UpdateTopRoutesEvent extends VerifyAccountEvent {
  final List topRoutes;
  final BuildContext context;

  const UpdateTopRoutesEvent({required this.topRoutes, required this.context});
  @override
  List<Object> get props => [topRoutes];
}

final class UpdateVehiclesEvent extends VerifyAccountEvent {
  final List vehicles;
  final BuildContext context;

  const UpdateVehiclesEvent({required this.vehicles, required this.context});
  @override
  List<Object> get props => [vehicles];
}
