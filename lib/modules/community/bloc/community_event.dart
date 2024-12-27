import 'package:equatable/equatable.dart';

sealed class CommunityEvent extends Equatable {
  const CommunityEvent();

  @override
  List<Object> get props => [];
}

final class LoadServicesData extends CommunityEvent {}

final class UpdateWalletBalance extends CommunityEvent {
  final int walletBalance;

  const UpdateWalletBalance(this.walletBalance);
  @override
  List<Object> get props => [walletBalance];
}
