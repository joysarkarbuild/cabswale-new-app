import 'package:equatable/equatable.dart';

sealed class WalletEvent extends Equatable {
  const WalletEvent();

  @override
  List<Object> get props => [];
}

final class FetchWalletTransactions extends WalletEvent {}

final class FetchWalletTransactionsMore extends WalletEvent {}
