import 'package:cabswalle/constants/assets.dart';
import 'package:cabswalle/widgets/submit_button.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class CheckinSuccessful extends StatelessWidget {
  const CheckinSuccessful({super.key, required this.cabCoins});
  final int cabCoins;

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
              Assets.animationsThankyou,
              width: MediaQuery.of(context).size.width * 0.6,
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                "Thank you for check in\n$cabCoins cab coins will be added to your account soon.",
                textAlign: TextAlign.center,
                style:
                    const TextStyle(fontSize: 26, fontWeight: FontWeight.w500),
              ),
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