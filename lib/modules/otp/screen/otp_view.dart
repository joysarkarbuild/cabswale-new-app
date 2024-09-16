import 'package:cabswalle/core/app_colors.dart';
import 'package:cabswalle/core/app_text_styles.dart';
import 'package:cabswalle/modules/login/screen/login_view.dart';
import 'package:cabswalle/widgets/submit_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:pinput/pinput.dart';

class OtpScreen extends StatelessWidget {
  const OtpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox(
        width: double.infinity,
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              headerContainer(
                  context, MediaQuery.of(context).size.height * 0.5),
              const SizedBox(
                height: 30,
              ),
              Text(
                "${AppLocalizations.of(context)!.otpverification} 9064983473", //need to chane here
                // 'We have sent verification code to $phoneNo',
                style: AppTextStyles.style15w500(),
              ),
              const SizedBox(
                height: 15,
              ),
              Pinput(
                length: 6,
                defaultPinTheme: PinTheme(
                    height: 50,
                    width: 50,
                    decoration: BoxDecoration(
                        border: Border.all(color: AppColors.myBlack45),
                        borderRadius: BorderRadius.circular(5))),
              ),
              const SizedBox(
                height: 15,
              ),
              RichText(
                text: TextSpan(
                    text: AppLocalizations.of(context)!.didntgetCode,
                    style: AppTextStyles.style16w600(),
                    children: [
                      // if (auth.timerValue > 0)
                      TextSpan(
                          text:
                              " ${AppLocalizations.of(context)!.resendOTP} in 30 sec",
                          style: const TextStyle(
                              color: AppColors.myprimaryColor, fontSize: 16)),
                      // if (auth.timerValue == 0)

                      // TextSpan(
                      //     text: " ${AppLocalizations.of(context)!.sendOTP}",
                      //     style: const TextStyle(
                      //         color: AppColors.myprimaryColor, fontSize: 16),
                      //     recognizer: TapGestureRecognizer()..onTap = () {})
                    ]),
              ),
              const SizedBox(
                height: 20,
              ),
              SubmitButton(
                  onTap: () {},
                  isAtBottom: true,
                  lable: AppLocalizations.of(context)!.verifyotp)
            ],
          ),
        ),
      ),
    );
  }
}
