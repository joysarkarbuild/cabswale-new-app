import 'package:cabswalle/services/login_manager.dart';
import 'package:cabswalle/widgets/common_widget_componants.dart';
import 'package:flutter/material.dart';
import 'package:otpless_flutter/otpless_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

class OtplessRepository {
  final _otplessFlutterPlugin = Otpless();
  final LoginManager loginManager = LoginManager();
  OtplessRepository() {
    _otplessFlutterPlugin.initHeadless("LJH15KV4GEXZ6SSZ92B3");
  }

  void setHeadlessCallback(Function(dynamic) onHeadlessResult) {
    _otplessFlutterPlugin.setHeadlessCallback(onHeadlessResult);
  }

  void sendOtp(
      {required String phoneNo,
      required BuildContext context,
      required bool isSms,
      required Function(dynamic) onHeadlessResult}) async {
    String phone = "+91$phoneNo";

    bool isBlocked = await loginManager.isBlock(phone);

    if (isBlocked) {
      showMyDialoge(
        // ignore: use_build_context_synchronously
        context: context,
        no: 'Ok',
        yes: "Call Now",
        onYes: () {
          launchUrl(Uri.parse("tel:+919403890306"));
        },
        content: const Text(
            'You have been blocked by the admin. Please contact the admin to resolve this issue.'),
      );
    } else {
      await loginManager.setActive(phoneNo);
      Map<String, dynamic> arg = {
        "phone": phoneNo,
        "countryCode": "+91",
        "deliveryChannel": isSms ? "SMS" : "WHATSAPP",
      };
      _otplessFlutterPlugin.startHeadless(onHeadlessResult, arg);
    }
  }

  void verifyOtp({
    required String phoneNo,
    required String otp,
    required Function(dynamic) onHeadlessResult,
  }) {
    Map<String, dynamic> arg = {
      "phone": phoneNo,
      "countryCode": "+91",
      "otp": otp,
    };
    _otplessFlutterPlugin.startHeadless(onHeadlessResult, arg);
  }
}
