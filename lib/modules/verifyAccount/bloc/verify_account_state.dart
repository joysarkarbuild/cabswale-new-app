import 'dart:io';

import 'package:equatable/equatable.dart';

sealed class VerifyAccountState extends Equatable {
  const VerifyAccountState();

  @override
  List<Object> get props => [];
}

final class VerifyAccountInitial extends VerifyAccountState {}

final class SelectProfileImageState extends VerifyAccountState {
  final File selectedImage;

  const SelectProfileImageState({required this.selectedImage});
  @override
  List<Object> get props => [selectedImage];
}

final class UpdateProfileLoading extends VerifyAccountState {}

final class UpdateProfileCompleteState extends VerifyAccountState {}

final class UpdateProfileErrorState extends VerifyAccountState {}
