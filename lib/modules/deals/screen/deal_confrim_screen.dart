import 'package:cabswalle/widgets/submit_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:lottie/lottie.dart';

class DealConfromScreen extends StatelessWidget {
  const DealConfromScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            LottieBuilder.asset(
              "assets/icons/hand_shake.json",
              width: MediaQuery.of(context).size.width * 0.6,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Deal confrimed  ",
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 22, fontWeight: FontWeight.w500),
                ),
                SvgPicture.asset(
                  "assets/icons/cabswale_coin.svg",
                  height: 30,
                ),
                Text(
                  " 100",
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.w500),
                ),
              ],
            ),
            Text(
              "Will be added to your wallet!",
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.w500),
            ),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: SubmitButton(
                onTap: () {
                  Navigator.pop(context);
                },
                lable: "OK",
                labelsize: 22,
                borderRadius: 5,
              ),
            )
          ],
        ),
      ),
    );
  }
}
