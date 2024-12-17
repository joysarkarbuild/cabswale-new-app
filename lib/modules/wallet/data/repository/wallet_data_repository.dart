import 'package:cabswalle/modules/wallet/data/models/transaction_model.dart';
import 'package:cabswalle/modules/wallet/data/models/transaction_response.dart';
import 'package:cabswalle/services/logger_service.dart';
import 'package:cabswalle/services/login_manager.dart';
import 'package:cabswalle/services/snackbar_service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class WalletDataRepository {
  Future<TransactionResponse> getWalletTransactions() async {
    List<TransactionModel> transactions = [];
    const int limit = 20; // Define the limit here
    try {
      LoggerService.logInfo("Getting Wallet Transaction Data");
      QuerySnapshot<Map<String, dynamic>> querySnapshot =
          await FirebaseFirestore.instance
              .collection("drivers")
              .doc(LoginManager.userId)
              .collection("walletTransactions")
              .orderBy("createdAt", descending: true)
              .limit(limit)
              .get();

      transactions.addAll(querySnapshot.docs
          .map((e) => TransactionModel.fromMap(e.data()))
          .toList());

      // Check if more documents are available
      bool hasMore = querySnapshot.docs.length == limit;

      return TransactionResponse(
          lastDocument:
              querySnapshot.docs.isNotEmpty ? querySnapshot.docs.last : null,
          transactions: transactions,
          hasMore: hasMore);
    } catch (e) {
      SnackbarUtils.showErrorSnackBar(message: e.toString());
      return TransactionResponse(
          lastDocument: null, transactions: transactions, hasMore: false);
    }
  }

  Future<TransactionResponse> getWalletTransactionsMore(
      DocumentSnapshot lastDocument) async {
    List<TransactionModel> transactions = [];
    const int limit = 20; // Define the limit here
    try {
      LoggerService.logInfo("Getting Wallet Transaction Data");
      QuerySnapshot<Map<String, dynamic>> querySnapshot =
          await FirebaseFirestore.instance
              .collection("drivers")
              .doc(LoginManager.userId)
              .collection("walletTransactions")
              .orderBy("createdAt", descending: true)
              .startAfterDocument(lastDocument)
              .limit(limit)
              .get();

      transactions.addAll(querySnapshot.docs
          .map((e) => TransactionModel.fromMap(e.data()))
          .toList());

      // Check if more documents are available
      bool hasMore = querySnapshot.docs.length == limit;

      return TransactionResponse(
          lastDocument:
              querySnapshot.docs.isNotEmpty ? querySnapshot.docs.last : null,
          transactions: transactions,
          hasMore: hasMore);
    } catch (e) {
      SnackbarUtils.showErrorSnackBar(message: e.toString());
      return TransactionResponse(
          lastDocument: null, transactions: transactions, hasMore: false);
    }
  }
}
