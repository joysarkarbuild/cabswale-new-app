import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

sealed class LoginEvent extends Equatable {
  const LoginEvent();

  @override
  List<Object> get props => [];
}

final class LoginClickEvent extends LoginEvent {
  final Function(String verificationId) onCodeSent;
  final Function(FirebaseAuthException e) onError;
  final String phoneNo;
  final BuildContext context;

  const LoginClickEvent(
      {required this.onCodeSent,
      required this.onError,
      required this.phoneNo,
      required this.context});

  @override
  List<Object> get props => [onCodeSent, onError, phoneNo];
}

final class StartVerificationEvent extends LoginEvent {
  const StartVerificationEvent();
  @override
  List<Object> get props => [];
}
