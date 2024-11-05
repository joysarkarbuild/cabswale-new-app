import 'package:equatable/equatable.dart';

sealed class MyprofileEvent extends Equatable {
  const MyprofileEvent();

  @override
  List<Object> get props => [];
}

final class MyProfileLoadEvent extends MyprofileEvent {}
