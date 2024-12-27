import 'package:cabswalle/modules/membership/payment_successful_page.dart';
import 'package:cabswalle/services/driver_service.dart';
import 'package:cabswalle/services/logger_service.dart';
import 'package:cabswalle/services/snackbar_service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';

class RazorpayService {
  late Razorpay _razorpay;

  RazorpayService() {
    _razorpay = Razorpay();
    _razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, _handlePaymentSuccess);
    _razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, _handlePaymentError);
    _razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, _handleExternalWallet);
  }

  String docId = "";
  int amountData = 0;
  String planType = "";
  bool fromHomeCome = false;
  BuildContext? gcontext;

  void openCheckout(
      {required String amount,
      required String name,
      required String description,
      required String contact,
      required String email,
      required String key,
      required String plan,
      bool? fromHome,
      required BuildContext context}) async {
    planType = plan;
    fromHomeCome = fromHome ?? false;
    var initData = await FirebaseFirestore.instance.collection("payments").add({
      "createdAt": DateTime.now(),
      "driver": {
        "name": DriverService.instance.driverModel!.name,
        "phoneNo": DriverService.instance.driverModel!.phoneNo,
        "uid": DriverService.instance.driverModel!.id,
      },
      "mode": "razorpay",
      "screenshotUrl": "",
      "status": "pending",
      "plan": plan,
      "amount": double.parse(amount) / 100
    });
    gcontext = context;
    docId = initData.id;
    amountData = int.parse(amount) ~/ 100;
    var options = {
      'key': key,
      'amount': amount, // Amount in paise
      'name': name,
      'description': description,
      'notes': [initData.id],
      'prefill': {'contact': contact, 'email': email}
    };

    try {
      _razorpay.open(options);
    } catch (e) {
      SnackbarUtils.showErrorSnackBar(message: "Something went wrong!");
    }
  }

  void _handlePaymentSuccess(PaymentSuccessResponse response) {
    FirebaseFirestore.instance.collection("payments").doc(docId).update({
      "updatedAt": DateTime.now(),
      "paymentDetails": {"id": response.paymentId ?? "", "status": true}
    });
    if (!fromHomeCome) {
      Navigator.pop(gcontext!);
    }

    Navigator.push(
      gcontext!,
      MaterialPageRoute(
        builder: (context) => PaymentSuccessful(
          amount: amountData,
          paymentId: docId,
          type: planType,
        ),
      ),
    );
  }

  void _handlePaymentError(PaymentFailureResponse response) {
    FirebaseFirestore.instance.collection("payments").doc(docId).update({
      "updatedAt": DateTime.now(),
      "paymentDetails": {"error": response.error ?? "", "status": false}
    });
  }

  void _handleExternalWallet(ExternalWalletResponse response) {
    LoggerService.logInfo("External Wallet: ${response.walletName}");
  }

  void dispose() {
    _razorpay.clear();
  }
}
