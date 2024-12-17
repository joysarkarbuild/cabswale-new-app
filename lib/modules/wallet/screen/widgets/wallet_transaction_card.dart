import 'package:cabswalle/constants/assets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';

class WalletTransactionCard extends StatelessWidget {
  const WalletTransactionCard(
      {super.key,
      required this.isDebited,
      required this.title,
      required this.amount,
      required this.dateTime});
  final bool isDebited;
  final String title;
  final int amount;
  final DateTime dateTime;

  @override
  Widget build(BuildContext context) {
    return Container(
        height: 77,
        margin: const EdgeInsets.symmetric(horizontal: 18, vertical: 5),
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.6,
                  child: Text(
                    title,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                        fontSize: 14, fontWeight: FontWeight.w500),
                  ),
                ),
                Text(
                  DateFormat('MMMM d, y ' ' h:mm a').format(dateTime),
                  style: const TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.w400,
                      color: Colors.black54),
                )
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text(
                  isDebited ? "- " : "+ ",
                  style: TextStyle(
                      fontSize: 18,
                      color: isDebited ? Colors.red : Colors.green,
                      fontWeight: FontWeight.w600),
                ),
                SvgPicture.asset(
                  Assets.iconsCabsCoin,
                  width: 16,
                ),
                Text(
                  " $amount",
                  style: TextStyle(
                      fontSize: 18,
                      color: isDebited ? Colors.red : Colors.green,
                      fontWeight: FontWeight.w600),
                )
              ],
            )
          ],
        ));
  }
}
