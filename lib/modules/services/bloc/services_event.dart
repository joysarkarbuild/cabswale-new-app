import 'package:equatable/equatable.dart';

sealed class ServicesEvent extends Equatable {
  const ServicesEvent();

  @override
  List<Object?> get props => [];
}

final class LoadServicesData extends ServicesEvent {}

final class UpdateWalletBalance extends ServicesEvent {
  final int walletBalance;

  const UpdateWalletBalance(this.walletBalance);

  @override
  List<Object?> get props => [walletBalance];
}
