import 'package:cabswalle/modules/wallet/data/models/transaction_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class TransactionResponse {
  final List<TransactionModel> transactions;
  final DocumentSnapshot? lastDocument;
  final bool hasMore;

  TransactionResponse(
      {required this.lastDocument,
      required this.transactions,
      required this.hasMore});
}
