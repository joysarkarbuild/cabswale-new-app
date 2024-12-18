import 'package:cabswalle/modules/insurance/insurance_screen1.dart';
import 'package:cabswalle/services/driver_service.dart';
import 'package:cabswalle/services/razor_pay_for_insurance.dart';
import 'package:cabswalle/widgets/submit_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:url_launcher/url_launcher.dart';

class InsuranceScreen2 extends StatefulWidget {
  const InsuranceScreen2({super.key, required this.paymentDetails});
  final Map<String, dynamic> paymentDetails;
  @override
  State<InsuranceScreen2> createState() => _InsuranceScreen2State();
}

class _InsuranceScreen2State extends State<InsuranceScreen2> {
  bool isPayed = insuranceMap["payment"] != null
      ? insuranceMap["payment"]["paymentDetails"] != null
          ? insuranceMap["payment"]["paymentDetails"]["status"]
          : false
      : false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Car Insurance"),
      ),
      body: SizedBox(
        height: MediaQuery.of(context).size.height,
        child: Column(
          children: [
            // BannerImage(
            //   bannerId: "insurance3",
            //   onTap: () {
            //     launchUrl(Uri.parse("tel:+919403890306"));
            //   },
            // ),
            SizedBox(
              height: 20,
            ),
            if (insuranceMap["status"] == "quotation" && !isPayed)
              Text(
                "Renewal Breakup",
                style: TextStyle(
                  fontSize: 20,
                ),
              ),
            if (insuranceMap["status"] == "quotation" && !isPayed)
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Premium : ",
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
                    ),
                    Text(
                      "RS ${insuranceMap["quotation"]["premium"]}",
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
                    )
                  ],
                ),
              ),
            if (insuranceMap["status"] == "quotation" && !isPayed)
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Discount(${((insuranceMap["quotation"]["discount"] / insuranceMap["quotation"]["premium"]) * 100).toStringAsFixed(1)}%) : ",
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
                    ),
                    Text(
                      "-RS ${insuranceMap["quotation"]["discount"]}",
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
                    )
                  ],
                ),
              ),
            if (insuranceMap["status"] == "quotation" && !isPayed)
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Cab Coins : ",
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
                    ),
                    Text(
                      "-RS ${insuranceMap["quotation"]["coins"]}",
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
                    )
                  ],
                ),
              ),
            if (insuranceMap["status"] == "quotation" && !isPayed)
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Divider(),
              ),
            if (insuranceMap["status"] == "quotation" && !isPayed)
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 30,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Final Premium : ",
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
                    ),
                    Text(
                      "RS ${insuranceMap["quotation"]["finalPremium"]}",
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
                    )
                  ],
                ),
              ),
            if (insuranceMap["status"] == "quotation" && !isPayed)
              const Spacer(),
            if (insuranceMap["status"] == "quotation" && !isPayed)
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 60, vertical: 10),
                child: SubmitButton(
                  onTap: () {
                    RazorpayInsuranceService rp = RazorpayInsuranceService();
                    rp.openCheckout(
                      docId: insuranceMap["docId"],
                      context: context,
                      plan: "customOffer",
                      amount: (insuranceMap["quotation"]["finalPremium"] * 100)
                          .toString(),
                      key: widget.paymentDetails["creds"]["key_id"],
                      // key: "rzp_test_WFDYMGr1LRBR2q",
                      name: widget.paymentDetails["name"],
                      contact:
                          DriverService.instance.driverModel!.phoneNo ?? "",
                      email: widget.paymentDetails["email"],
                    );
                  },
                  lable: "PAY RS ${insuranceMap["quotation"]["finalPremium"]}",
                  labelsize: 20,
                  borderRadius: 6,
                ),
              ),
            const SizedBox(
              height: 8,
            ),
            if (insuranceMap["status"] == "quotation" && isPayed)
              Container(
                decoration: BoxDecoration(
                    border: Border.all(color: Colors.blue),
                    color: Colors.green.withValues(alpha: 0.4)),
                margin: const EdgeInsets.symmetric(horizontal: 20),
                child: const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text(
                    "Your payment has been done. Our team is processing it and will update you when it's complete.",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontSize: 20,
                        color: Colors.black,
                        fontWeight: FontWeight.w500),
                  ),
                ),
              ),
            if (insuranceMap["status"] == "pending")
              Container(
                decoration: BoxDecoration(
                    border: Border.all(color: Colors.blue),
                    color: Colors.green.withValues(alpha: 0.4)),
                margin: const EdgeInsets.symmetric(horizontal: 20),
                child: const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text(
                    "Your Insurance Details has been submited. Our customer service will call you for further process.",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontSize: 20,
                        color: Colors.black,
                        fontWeight: FontWeight.w500),
                  ),
                ),
              ),
            const Spacer(),
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
                            // if (await canLaunch(url)) {
                            await launchUrl(Uri.parse(url));
                            debugPrint('sending message: $url');
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.blue,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(2),
                            ),
                            minimumSize: Size(
                                MediaQuery.of(context).size.width * 0.42,
                                40), // Adjust the size as per your requirement
                            padding: const EdgeInsets.symmetric(
                                horizontal: 12,
                                vertical:
                                    6), // Adjust the padding as per your requirement
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
                            backgroundColor: Colors.blue,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(2),
                            ),
                            minimumSize: Size(
                                MediaQuery.of(context).size.width * 0.42,
                                40), // Adjust the size as per your requirement
                            padding: const EdgeInsets.symmetric(
                                horizontal: 12,
                                vertical:
                                    6), // Adjust the padding as per your requirement
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
    );
  }
}
