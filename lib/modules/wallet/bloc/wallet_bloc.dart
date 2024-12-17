import 'package:bloc/bloc.dart';
import 'package:cabswalle/modules/wallet/bloc/wallet_event.dart';
import 'package:cabswalle/modules/wallet/bloc/wallet_state.dart';
import 'package:cabswalle/modules/wallet/data/models/transaction_model.dart';
import 'package:cabswalle/modules/wallet/data/models/transaction_response.dart';
import 'package:cabswalle/modules/wallet/data/repository/wallet_data_repository.dart';

class WalletBloc extends Bloc<WalletEvent, WalletState> {
  WalletBloc() : super(WalletInitial()) {
    WalletDataRepository walletDataRepository = WalletDataRepository();
    on<WalletEvent>((event, emit) {});
    on<FetchWalletTransactions>(
      (event, emit) async {
        emit(WalletTransactionLoading());
        TransactionResponse response =
            await walletDataRepository.getWalletTransactions();
        emit(WalletTransactionLoaded(transactions: response));
      },
    );

    on<FetchWalletTransactionsMore>(
      (event, emit) async {
        TransactionResponse response =
            await walletDataRepository.getWalletTransactionsMore(
                (state as WalletTransactionLoaded).transactions.lastDocument!);
        List<TransactionModel> tr =
            (state as WalletTransactionLoaded).transactions.transactions;
        tr.addAll(response.transactions);
        TransactionResponse res2 = TransactionResponse(
            lastDocument: response.lastDocument,
            transactions: tr,
            hasMore: response.hasMore);
        emit(WalletTransactionLoaded(transactions: res2));
      },
    );
  }
}
