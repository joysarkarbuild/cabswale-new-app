import 'package:equatable/equatable.dart';

sealed class CommunityState extends Equatable {
  const CommunityState();

  @override
  List<Object> get props => [];
}

final class CommunityInitial extends CommunityState {}

final class CommunityLoading extends CommunityState {}

final class CommunityLoaded extends CommunityState {
  final Map<String, dynamic> community;
  final int walletBalance;

  const CommunityLoaded(
    this.community,
    this.walletBalance,
  );

  @override
  List<Object> get props => [walletBalance, community];
}

final class CommunityError extends CommunityState {
  final String message;

  const CommunityError(this.message);

  @override
  List<Object> get props => [message];
}
