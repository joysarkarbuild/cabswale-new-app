import 'package:cabswalle/constants/assets.dart';
import 'package:cabswalle/widgets/submit_button.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class ThankYouScreenSaveMoney extends StatelessWidget {
  const ThankYouScreenSaveMoney({super.key});

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
            const Padding(
              padding: EdgeInsets.all(16.0),
              child: Text(
                "Thank you for your interest in partnership,\nOur team will call you soon.",
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 26, fontWeight: FontWeight.w500),
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
