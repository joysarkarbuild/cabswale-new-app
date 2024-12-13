import 'package:cabswalle/core/app_colors.dart';
import 'package:cabswalle/modules/home/data/models/lead_data_model.dart';
import 'package:cabswalle/widgets/common_widget_componants.dart';
import 'package:cabswalle/widgets/lead_card.dart';
import 'package:cabswalle/widgets/lead_card_shimmer.dart';
import 'package:cabswalle/widgets/submit_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class MyLeadsScreen extends StatefulWidget {
  const MyLeadsScreen({super.key});
  static const route = '/myleadsscreen';

  @override
  State<MyLeadsScreen> createState() => _MyLeadsScreenState();
}

class _MyLeadsScreenState extends State<MyLeadsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: myAppBar(
          context: context,
          title: AppLocalizations.of(context)!.myLeads,
          leading: true,
          centerTitle: true),
      body: ListView(
        children: [
          SubmitButton(
            onTap: () async {},
            margin: 15,
            lable: AppLocalizations.of(context)!.addLeads,
            icon: const Icon(
              Icons.add,
              color: AppColors.myWhite,
            ),
          ),
          const SizedBox(
            height: 4,
          ),
          ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: 1,
              itemBuilder: (ctx, index) {
                if (false) {
                  return const LeadsCardShimmer();
                } else if (true) {
                  return Container(
                      height: 200,
                      alignment: Alignment.center,
                      child: Text(
                          '${AppLocalizations.of(context)!.notfount(AppLocalizations.of(context)!.leads)} !'));
                } else {
                  return LeadsCard(
                    lead: LeadModel(),
                  );
                }
              }),
        ],
      ),
    );
  }
}
