import 'package:cabswalle/modules/extraBenifits/data/models/partner_model.dart';
import 'package:cabswalle/widgets/common_image_view.dart';
import 'package:flutter/material.dart';

class EarnMoneyCard extends StatelessWidget {
  const EarnMoneyCard(
      {super.key, required this.partner, required this.distance});
  final Partner partner;
  final double distance;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {},
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