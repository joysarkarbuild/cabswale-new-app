import 'package:equatable/equatable.dart';

sealed class CommunityState extends Equatable {
  const CommunityState();

  @override
  List<Object> get props => [];
}

final class CommunityInitial extends CommunityState {}
