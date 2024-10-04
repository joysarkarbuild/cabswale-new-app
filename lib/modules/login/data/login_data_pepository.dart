import 'package:otpless_flutter/otpless_flutter.dart';

class OtplessRepository {
  final _otplessFlutterPlugin = Otpless();

  OtplessRepository() {
    _otplessFlutterPlugin.initHeadless("LJH15KV4GEXZ6SSZ92B3");
  }

  void setHeadlessCallback(Function(dynamic) onHeadlessResult) {
    _otplessFlutterPlugin.setHeadlessCallback(onHeadlessResult);
  }

  void sendOtp(
      {required String phoneNo, required Function(dynamic) onHeadlessResult}) {
    Map<String, dynamic> arg = {"phone": phoneNo, "countryCode": "+91"};
    _otplessFlutterPlugin.startHeadless(onHeadlessResult, arg);
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
