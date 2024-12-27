import 'package:cabswalle/core/app_colors.dart';
import 'package:cabswalle/core/app_text_styles.dart';
import 'package:cabswalle/modules/login/screen/login_view.dart';
import 'package:cabswalle/modules/loginOtpless/data/login_data_pepository.dart';
import 'package:cabswalle/routes/app_routes.dart';
import 'package:cabswalle/services/loading_overlay_service.dart';
import 'package:cabswalle/services/logger_service.dart';
import 'package:cabswalle/services/login_manager.dart';
import 'package:cabswalle/services/snackbar_service.dart';
import 'package:cabswalle/widgets/submit_button.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:go_router/go_router.dart';
import 'package:pinput/pinput.dart';
import 'dart:async';

class OtpScreenOtpless extends StatefulWidget {
  final String phoneNo;
  final bool isSms;

  const OtpScreenOtpless(
      {super.key, required this.phoneNo, required this.isSms});

  @override
  State<OtpScreenOtpless> createState() => _OtpScreenOtplessState();
}

class _OtpScreenOtplessState extends State<OtpScreenOtpless> {
  final TextEditingController _otpController = TextEditingController();
  final OtplessRepository _otplessRepository =
      OtplessRepository(); // Initialize OtplessRepository

  int _timerValue = 30; // Timer countdown value
  bool _canResendOtp = false;
  Timer? _timer;
  LoginManager loginManager = LoginManager();

  @override
  void initState() {
    super.initState();
    startTimer();
    _otplessRepository.setHeadlessCallback(onHeadlessResult); // Set callback
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
    final phoneNo = widget.phoneNo.trim();
    // Call resend OTP API
    setState(() {
      _timerValue = 30; // Reset timer
      _canResendOtp = false; // Disable resend button
    });
    startTimer();

    // Resend OTP using the repository
    _otplessRepository.sendOtp(
        onHeadlessResult: onHeadlessResultResend,
        phoneNo: phoneNo,
        isSms: widget.isSms,
        context: context);
    LoadingOverlay().hide();
  }

  void onHeadlessResultResend(dynamic result) {
    if (result['statusCode'] == 200) {
      switch (result['responseType'] as String) {
        case 'INITIATE':
          {
            SnackbarUtils.showSuccessSnackBar(
                message: "OTP Sent Successfully!");
          }
          break;
        default:
          {
            SnackbarUtils.showErrorSnackBar(message: "Something Went Wrong!");
          }
          break;
      }
    } else {
      LoadingOverlay().hide();
      SnackbarUtils.showErrorSnackBar(message: "Something Went Wrong!");
    }
  }

  void onHeadlessResult(dynamic result) async {
    if (result['statusCode'] == 200) {
      LoggerService.logInfo(result["response"]["firebaseInfo"].toString());
      await loginManager.verifyOtpUsingOtpLess(
          token: result["response"]["firebaseInfo"]["firebaseToken"].toString(),
          context: context);
      LoadingOverlay().hide();
    } else {
      LoadingOverlay().hide();
      SnackbarUtils.showErrorSnackBar(message: "Incorrect OTP!");
    }
  }

  void gotoNavbar() {
    context.goNamed(Names.navbar);
  }

  void verifyOtp() {
    LoadingOverlay().show(context);
    final otp = _otpController.text.trim();
    final phoneNo = widget.phoneNo.trim();

    if (otp.length == 6) {
      // Call OTP verification logic from the repository
      _otplessRepository.verifyOtp(
        phoneNo: phoneNo,
        otp: otp,
        onHeadlessResult: onHeadlessResult,
      );
    } else {
      LoadingOverlay().hide();
      SnackbarUtils.showErrorSnackBar(message: "Invalid OTP!");
    }
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
