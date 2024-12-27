import 'package:cabswalle/core/app_colors.dart';
import 'package:cabswalle/modules/membership/plans_screen.dart';
import 'package:cabswalle/services/driver_service.dart';
import 'package:cabswalle/services/razor_pay_service.dart';
import 'package:cabswalle/widgets/common_image_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:lottie/lottie.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';

class PaymentSuccessful extends StatefulWidget {
  const PaymentSuccessful({
    super.key,
    required this.amount,
    required this.paymentId,
    required this.type,
  });
  final int amount;
  final String paymentId;
  final String type;

  @override
  State<PaymentSuccessful> createState() => _PaymentSuccessfulState();
}

class _PaymentSuccessfulState extends State<PaymentSuccessful> {
  bool isActiveExtra = false;
  String imgUrl = "";
  String offerType = "";

  void updateLocalPlan({required String plan}) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString("planType", plan);
    prefs.setString("planTime", DateTime.now().toIso8601String());
  }

  void clearLocalPlan() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString("planType", "");
    prefs.setString("planTime", "");
  }

  void checkAcitive() {
    if (widget.type == "dailyOffer" ||
        widget.type == "monthlyOffer" ||
        widget.type == "yearlyOffer") {
      clearLocalPlan();
    }
    if (widget.type == "daily") {
      offerType = "dailyOffer";
      isActiveExtra = paymentDetailsMain["dailyOffer"] != null
          ? paymentDetailsMain["dailyOffer"]["active"]
          : false;
      imgUrl = paymentDetailsMain["dailyOffer"] != null
          ? paymentDetailsMain["dailyOffer"]["url"]
          : "";
      updateLocalPlan(plan: "dailyOffer");
    }
    if (widget.type == "monthly") {
      offerType = "monthlyOffer";
      isActiveExtra = paymentDetailsMain["monthlyOffer"] != null
          ? paymentDetailsMain["monthlyOffer"]["active"]
          : false;
      imgUrl = paymentDetailsMain["monthlyOffer"] != null
          ? paymentDetailsMain["monthlyOffer"]["url"]
          : "";
      updateLocalPlan(plan: "monthlyOffer");
    }
    if (widget.type == "yearly") {
      offerType = "yearlyOffer";
      isActiveExtra = paymentDetailsMain["yearlyOffer"] != null
          ? paymentDetailsMain["yearlyOffer"]["active"]
          : false;
      imgUrl = paymentDetailsMain["yearlyOffer"] != null
          ? paymentDetailsMain["yearlyOffer"]["url"]
          : "";
      updateLocalPlan(plan: "yearlyOffer");
    }
  }

  @override
  void initState() {
    super.initState();
    checkAcitive();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Payment Successful",
          style: TextStyle(
              color: Colors.blue, fontSize: 24, fontWeight: FontWeight.w800),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        // Wrap with SingleChildScrollView
        child: Padding(
          padding: const EdgeInsets.all(0.0),
          child: Column(
            children: [
              LottieBuilder.asset(
                "assets/icons/cab_coin.json",
                frameRate: FrameRate.max,
                width: isActiveExtra
                    ? MediaQuery.of(context).size.width * 0.40
                    : MediaQuery.of(context).size.width * 0.50,
                height: isActiveExtra
                    ? MediaQuery.of(context).size.width * 0.40
                    : MediaQuery.of(context).size.width * 0.50,
                fit: BoxFit.cover,
              ),
              Text(
                "${paymentDetailsMain["coins"][widget.type]} cab coins added to your wallet",
                style: const TextStyle(
                    color: Colors.blue,
                    fontSize: 16,
                    fontWeight: FontWeight.w800),
              ),

              const SizedBox(
                height: 2,
              ),
              Text(
                "Total amount paid ₹${widget.amount}",
                style: const TextStyle(
                    color: Colors.black,
                    fontSize: 18,
                    fontWeight: FontWeight.w600),
              ),
              const SizedBox(
                height: 3,
              ),
              SelectableText(
                "Payment Id : ${widget.paymentId}",
                style: const TextStyle(
                    color: Colors.black,
                    fontSize: 15,
                    fontWeight: FontWeight.w500),
              ),
              const SizedBox(
                height: 3,
              ),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 20),
                child: Text(
                  "Thank you for the payment sometimes it takes 5-10 minutes to activate the plan",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      color: Colors.blue,
                      fontSize: 14,
                      fontWeight: FontWeight.w500),
                ),
              ),
              if (isActiveExtra)
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                  child: InkWell(
                      onTap: () {
                        RazorpayService rp = RazorpayService();
                        rp.openCheckout(
                          context: context,
                          plan: offerType,
                          amount:
                              (paymentDetailsMain[offerType]["amount"] * 100)
                                  .toString(),
                          key: paymentDetailsMain["key_id"],
                          // key: "rzp_test_WFDYMGr1LRBR2q",
                          name: paymentDetailsMain["name"],
                          description: paymentDetailsMain["description"],
                          contact: DriverService.instance.driverModel!.phoneNo,
                          email: paymentDetailsMain["email"],
                          fromHome: false,
                        );
                      },
                      child: CommonImageView(url: imgUrl)),
                ),
              if (!isActiveExtra)
                const SizedBox(
                  height: 20,
                ),
              ElevatedButton(
                onPressed: () async {
                  await DriverService.instance.loadDriverModel();
                  // ignore: use_build_context_synchronously
                  Navigator.pop(context);
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(2),
                  ),
                  minimumSize: Size(MediaQuery.of(context).size.width * 0.42,
                      40), // Adjust the size as per your requirement
                  padding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical:
                          6), // Adjust the padding as per your requirement
                ),
                child: const Text(
                  'Go back to Get Duties',
                  style: TextStyle(color: Colors.white),
                ),
              ),
              const SizedBox(
                  height:
                      20), // Added to avoid overlapping with the spacer below
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    "If you are facing any issues, connect with us",
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          ElevatedButton(
                            onPressed: () async {
                              String url = 'https://wa.me/9368006253/';
                              await launchUrl(Uri.parse(url));
                              debugPrint('sending message: $url');
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: AppColors.myprimaryColor,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(2),
                              ),
                              minimumSize: Size(
                                  MediaQuery.of(context).size.width * 0.42, 40),
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 12, vertical: 6),
                            ),
                            child: Row(
                              children: [
                                SvgPicture.asset(
                                  'assets/icons/whatsapp.svg',
                                  height: 26,
                                ),
                                const Padding(
                                  padding: EdgeInsets.only(left: 10),
                                  child: Text(
                                    'WhatsApp',
                                    style: TextStyle(color: Colors.white),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          ElevatedButton(
                            onPressed: () {
                              launchUrl(Uri.parse("tel:+91940389036"));
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: AppColors.myprimaryColor,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(2),
                              ),
                              minimumSize: Size(
                                  MediaQuery.of(context).size.width * 0.42, 40),
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 12, vertical: 6),
                            ),
                            child: const Row(
                              children: [
                                Icon(
                                  Icons.phone,
                                  color: Colors.white,
                                ),
                                Padding(
                                  padding: EdgeInsets.only(left: 10),
                                  child: Text(
                                    'Call',
                                    style: TextStyle(color: Colors.white),
                                  ),
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                  const Text(
                    "Timing: Monday to Sunday 9am to 12am",
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
              const SizedBox(
                height: 20,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
