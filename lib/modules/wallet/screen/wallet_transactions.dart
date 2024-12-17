import 'package:cabswalle/modules/wallet/bloc/wallet_bloc.dart';
import 'package:cabswalle/modules/wallet/bloc/wallet_event.dart';
import 'package:cabswalle/modules/wallet/bloc/wallet_state.dart';
import 'package:cabswalle/modules/wallet/screen/widgets/wallet_transaction_card.dart';
import 'package:cabswalle/services/logger_service.dart';
import 'package:cabswalle/widgets/centre_loading.dart';
import 'package:cabswalle/widgets/common_widget_componants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class WalletTransactionScreen extends StatefulWidget {
  const WalletTransactionScreen({super.key});

  @override
  State<WalletTransactionScreen> createState() =>
      _WalletTransactionScreenState();
}

class _WalletTransactionScreenState extends State<WalletTransactionScreen> {
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    context.read<WalletBloc>().add(FetchWalletTransactions());

    _scrollController.addListener(() {
      if (_scrollController.position.pixels >=
          _scrollController.position.maxScrollExtent - 10) {
        final state = context.read<WalletBloc>().state;
        if (state is WalletTransactionLoaded && state.transactions.hasMore) {
          context.read<WalletBloc>().add(FetchWalletTransactionsMore());
        } else {
          LoggerService.logInfo("Has no more data");
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: myAppBar(
          context: context, title: "Wallet Transactions", centerTitle: true),
      body: BlocBuilder<WalletBloc, WalletState>(
        builder: (context, state) {
          if (state is WalletTransactionLoaded) {
            if (state.transactions.transactions.isEmpty) {
              return Center(
                child: Text("No Transactions Yet!"),
              );
            }
            return ListView.builder(
              controller: _scrollController,
              itemCount: state.transactions.transactions.length,
              itemBuilder: (context, index) => WalletTransactionCard(
                  isDebited:
                      state.transactions.transactions[index].type == "credit"
                          ? false
                          : true,
                  title: state.transactions.transactions[index].msg,
                  amount: state.transactions.transactions[index].amount.toInt(),
                  dateTime: state.transactions.transactions[index].createdAt),
            );
          } else if (state is WalletTransactionLoading) {
            return CentreLoading();
          } else {
            return SizedBox();
          }
        },
      ),
    );
  }
}
