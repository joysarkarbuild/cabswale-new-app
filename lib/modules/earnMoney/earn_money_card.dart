import 'package:cabswalle/models/partner_setails.dart';
import 'package:cabswalle/modules/earnMoney/parner_details_screen.dart';
import 'package:cabswalle/widgets/common_image_view.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class EarnMoneyCard extends StatelessWidget {
  const EarnMoneyCard(
      {super.key, required this.partner, required this.distance});
  final Partner partner;
  final double distance;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        FirebaseFirestore.instance.collection("clicks").add({
          "driverId": FirebaseAuth.instance.currentUser!.uid,
          "id": partner.partnerId,
          "branchId": partner.id,
          "type": "partner",
          "createdAt": DateTime.now(),
        });

        Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => PartnerDetailsScreen(
                partner: partner,
              ),
            ));
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 5),
        child: SizedBox(
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 10, vertical: 2),
                    decoration: const BoxDecoration(
                      color: Colors.deepPurple,
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(6),
                          topRight: Radius.circular(6)),
                    ),
                    child: Text(
                      partner.location,
                      style: const TextStyle(
                          color: Colors.white, fontWeight: FontWeight.bold),
                    ),
                  ),
                  Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 10, vertical: 2),
                    decoration: const BoxDecoration(
                      color: Colors.green,
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(6),
                          topRight: Radius.circular(6)),
                    ),
                    child: Text(
                      (distance).toInt() >= 1000
                          ? " ${distance ~/ 1000} km"
                          : "${distance.toInt()} m",
                      style: const TextStyle(
                          color: Colors.white, fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
              ),
              CommonImageView(
                width: MediaQuery.of(context).size.width,
                url: partner.partnerDetails.coverPic,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
