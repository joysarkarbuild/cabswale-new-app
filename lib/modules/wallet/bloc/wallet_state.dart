import 'package:cabswalle/modules/wallet/data/models/transaction_response.dart';
import 'package:equatable/equatable.dart';

sealed class WalletState extends Equatable {
  const WalletState();

  @override
  List<Object> get props => [];
}

final class WalletInitial extends WalletState {}

final class WalletTransactionLoading extends WalletState {}

final class WalletTransactionLoaded extends WalletState {
  final TransactionResponse transactions;

  const WalletTransactionLoaded({required this.transactions});
  @override
  List<Object> get props => [transactions];
}
