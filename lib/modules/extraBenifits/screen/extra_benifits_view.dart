import 'package:cabswalle/modules/extraBenifits/data/models/partner_model.dart';
import 'package:cabswalle/services/calculation_util.dart';
import 'package:cabswalle/widgets/earn_money_card.dart';
import 'package:flutter/material.dart';

class ExtraBenifitsScreen extends StatelessWidget {
  const ExtraBenifitsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Extra Benefits"),
        centerTitle: true,
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(14),
        itemCount: dummyPartner.length,
        itemBuilder: (context, index) {
          final e = dummyPartner[index];
          return EarnMoneyCard(
            partner: e,
            distance: CalculationUtil.calculateDistanceInMeters(
                double.parse(e.address.coordinates[0]),
                double.parse(e.address.coordinates[1])),
          );
        },
      ),
    );
  }
}
