import 'package:cabswalle/modules/insurance/insurance_screen3.dart';
import 'package:cabswalle/services/driver_service.dart';
import 'package:cabswalle/services/snackbar_service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';

class RazorpayInsuranceService {
  late Razorpay _razorpay;

  RazorpayInsuranceService() {
    _razorpay = Razorpay();
    _razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, _handlePaymentSuccess2);
    _razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, _handlePaymentError);
    _razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, _handleExternalWallet);
  }

  String docIdMain = "";

  int amountData = 0;

  BuildContext? gcontext;

  void openCheckout(
      {required String amount,
      required String name,
      required String contact,
      required String email,
      required String key,
      required String plan,
      required String docId,
      required BuildContext context}) async {
    docIdMain = docId;
    gcontext = context;
    await FirebaseFirestore.instance
        .collection("insuranceRequests")
        .doc(docId)
        .update({
      "payment": {
        "createdAt": DateTime.now(),
        "driver": {
          "name": DriverService.instance.driverModel!.name!.isNotEmpty
              ? DriverService.instance.driverModel!.name
              : "Cabswale Partner",
          "phoneNo": DriverService.instance.driverModel!.phoneNo ?? "",
          "uid": DriverService.instance.driverModel!.id ?? "",
        },
        "mode": "razorpay",
        "screenshotUrl": "",
        "status": "init",
        "plan": plan,
        "amount": double.parse(amount) / 100
      }
    });
    docIdMain = docId;
    amountData = int.parse(amount) ~/ 100;
    var options = {
      'key': key,
      'amount': amount, // Amount in paise
      'name': name,
      'prefill': {'contact': contact, 'email': email}
    };

    try {
      _razorpay.open(options);
    } catch (e) {
      SnackbarUtils.showErrorSnackBar(message: "Something went wrong!");
    }
  }

  void _handlePaymentSuccess2(PaymentSuccessResponse response) {
    FirebaseFirestore.instance
        .collection("insuranceRequests")
        .doc(docIdMain)
        .update({
      "updatedAt": DateTime.now(),
      "status": "completed",
      "paymentDetails": {"id": response.paymentId ?? "", "status": true}
    });
    Navigator.pushReplacement(
        gcontext!,
        MaterialPageRoute(
          builder: (context) => const InsuranceScreen3(),
        ));
  }

  void _handlePaymentError(PaymentFailureResponse response) {
    FirebaseFirestore.instance.collection("payments").doc(docIdMain).update({
      "updatedAt": DateTime.now(),
      "paymentDetails": {"error": response.error ?? "", "status": false}
    });
  }

  void _handleExternalWallet(ExternalWalletResponse response) {
    SnackbarUtils.showErrorSnackBar(
        message: "External Wallet: ${response.walletName}");
  }

  void dispose() {
    _razorpay.clear();
  }
}
