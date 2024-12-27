import 'package:cabswalle/modules/saveMoney/save_mone_thankyou_screen.dart';
import 'package:cabswalle/services/driver_service.dart';
import 'package:cabswalle/widgets/banner_widget.dart';
import 'package:cabswalle/widgets/submit_button.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class PartnerWithUsScreen extends StatelessWidget {
  const PartnerWithUsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Partner with us"),
        centerTitle: true,
      ),
      body: Stack(
        children: [
          SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const BannerImage(bannerId: "partner"),
                  const SizedBox(height: 20),
                  Text(
                    "Join us and start your journey as a partner. Enjoy exclusive benefits and grow with us.",
                    style: TextStyle(fontSize: 16),
                  ),
                  const SizedBox(height: 80), // Space for the fixed button
                ],
              ),
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: const EdgeInsets.all(10),
              child: SubmitButton(
                onTap: () {
                  FirebaseFirestore.instance.collection("partnerRequests").add({
                    "createdAt": DateTime.now(),
                    "driverId": FirebaseAuth.instance.currentUser!.uid,
                    "phoneNo": DriverService.instance.driverModel!.phoneNo
                  }).then((value) {
                    Navigator.pushReplacement(
                        // ignore: use_build_context_synchronously
                        context,
                        MaterialPageRoute(
                          builder: (context) => const ThankYouScreenSaveMoney(),
                        ));
                  });
                },
                lable: "I am interested",
                borderRadius: 8,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
