import 'package:cabswalle/services/driver_service.dart';
import 'package:cabswalle/widgets/submit_button.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:url_launcher/url_launcher.dart';

class InsuranceScreen3 extends StatefulWidget {
  const InsuranceScreen3({super.key});

  @override
  State<InsuranceScreen3> createState() => _InsuranceScreen3State();
}

class _InsuranceScreen3State extends State<InsuranceScreen3> {
  void _showThankYouDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Thank You'),
          content: Text(
              'Thanks for your interest. Our customer service will contact you soon.'),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
              },
              child: Text('OK'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Car Insurance"),
      ),
      body: Column(
        children: [
          // BannerImage(
          //   bannerId: "insurance4",
          //   onTap: () {
          //     launchUrl(Uri.parse("tel:+919403890306"));
          //   },
          // ),
          SizedBox(
            height: 20,
          ),
          // BannerImage(
          //   bannerId: "insurance5",
          //   onTap: () {
          //     launchUrl(Uri.parse("tel:+919403890306"));
          //   },
          // ),
          SizedBox(
            height: 20,
          ),
          Spacer(),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: SubmitButton(
              onTap: () async {
                await FirebaseFirestore.instance
                    .collection("community")
                    .doc("insuranceAgentRequests")
                    .collection("list")
                    .add({
                  "createdAt": DateTime.now(),
                  "id": DriverService.instance.driverModel!.id,
                  "phoneNo": DriverService.instance.driverModel!.phoneNo,
                  "name": DriverService.instance.driverModel!.name,
                  "problem": "Intrested to become an insurance partner",
                });
                _showThankYouDialog();
              },
              lable: "Become an Insurance Partner",
              borderRadius: 6,
            ),
          ),
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
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
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
          SizedBox(
            height: 10,
          ),
        ],
      ),
    );
  }
}
