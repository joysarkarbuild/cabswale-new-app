import 'package:cabswalle/core/app_colors.dart';
import 'package:cabswalle/core/app_text_styles.dart';
import 'package:cabswalle/modules/login/data/login_data_repository.dart';
import 'package:cabswalle/modules/login/screen/login_view.dart';
import 'package:cabswalle/services/loading_overlay_service.dart';
import 'package:cabswalle/services/login_manager.dart';
import 'package:cabswalle/widgets/submit_button.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:pinput/pinput.dart';
import 'dart:async';

class OtpScreen extends StatefulWidget {
  final String phoneNo;
  final String verificationId;

  const OtpScreen(
      {super.key, required this.phoneNo, required this.verificationId});

  @override
  State<OtpScreen> createState() => _OtpScreenState();
}

class _OtpScreenState extends State<OtpScreen> {
  final TextEditingController _otpController = TextEditingController();
  final LoginManager loginManager = LoginManager();
  int _timerValue = 30; // Timer countdown value
  bool _canResendOtp = false;
  Timer? _timer;

  String localVerificationId = "";

  final LoginDataRepository loginDataRepository = LoginDataRepository();

  @override
  void initState() {
    super.initState();
    startTimer();
  }

  @override
  void dispose() {
    _otpController.dispose();
    _timer?.cancel(); // Dispose the timer
    super.dispose();
  }

  void startTimer() {
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_timerValue > 0) {
        setState(() {
          _timerValue--;
        });
      } else {
        setState(() {
          _canResendOtp = true; // Enable resend OTP button after countdown
          _timer?.cancel();
        });
      }
    });
  }

  void resendOtp() async {
    LoadingOverlay().show(context);
    // Call resend OTP API
    localVerificationId =
        await loginDataRepository.onSubmit(context, widget.phoneNo, true);
    setState(() {
      _timerValue = 30; // Reset timer
      _canResendOtp = false; // Disable resend button
    });
    startTimer();

    // Resend OTP using the repository

    LoadingOverlay().hide();
  }

  verifyOtp() async {
    LoadingOverlay().show(context);
    localVerificationId = widget.verificationId;
    await loginManager.verifyOtp(
        smsCode: _otpController.text.trim(),
        context: context,
        phoneNo: "+91${widget.phoneNo}",
        verificationId: localVerificationId);

    LoadingOverlay().hide();
  }

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
              // Dynamic phone number display
              Text(
                "${AppLocalizations.of(context)!.otpverification} +91-${widget.phoneNo}",
                style: AppTextStyles.style15w500(),
              ),
              const SizedBox(
                height: 15,
              ),
              // OTP input using Pinput
              Pinput(
                length: 6,
                controller: _otpController,
                defaultPinTheme: PinTheme(
                  height: 50,
                  width: 50,
                  decoration: BoxDecoration(
                    border: Border.all(color: AppColors.myBlack45),
                    borderRadius: BorderRadius.circular(5),
                  ),
                ),
              ),
              const SizedBox(
                height: 15,
              ),
              RichText(
                text: TextSpan(
                  text: AppLocalizations.of(context)!.didntgetCode,
                  style: AppTextStyles.style13w600(),
                  children: [
                    if (_timerValue > 0)
                      TextSpan(
                        text:
                            " ${AppLocalizations.of(context)!.resendOTP} in $_timerValue seconds",
                        style: const TextStyle(
                          color: AppColors.myprimaryColor,
                          fontSize: 14,
                        ),
                      ),
                    if (_canResendOtp)
                      TextSpan(
                        text: " ${AppLocalizations.of(context)!.resendOTP}",
                        style: const TextStyle(
                          color: AppColors.myprimaryColor,
                          fontSize: 16,
                        ),
                        recognizer: TapGestureRecognizer()
                          ..onTap = resendOtp, // Handle OTP resend
                      ),
                  ],
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              // Submit button to verify OTP
              SubmitButton(
                onTap: verifyOtp,
                isAtBottom: true,
                borderRadius: 5,
                lable: AppLocalizations.of(context)!.verifyotp,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
