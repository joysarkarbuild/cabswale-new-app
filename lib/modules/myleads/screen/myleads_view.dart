import 'package:cabswalle/core/app_colors.dart';
import 'package:cabswalle/core/app_text_styles.dart';
import 'package:cabswalle/modules/myleads/bloc/myleads_bloc.dart';
import 'package:cabswalle/modules/myleads/bloc/myleads_event.dart';
import 'package:cabswalle/modules/myleads/bloc/myleads_state.dart';
import 'package:cabswalle/routes/app_routes.dart';
import 'package:cabswalle/widgets/common_widget_componants.dart';
import 'package:cabswalle/widgets/lead_card_shimmer.dart';
import 'package:cabswalle/widgets/my_lead_card.dart';
import 'package:cabswalle/widgets/submit_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:go_router/go_router.dart';

class MyLeadsScreen extends StatelessWidget {
  const MyLeadsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    context.read<MyleadsBloc>().add(FetchMyLeads());
    return Scaffold(
      appBar: myAppBar(
          context: context,
          title: AppLocalizations.of(context)!.myLeads,
          leading: true,
          centerTitle: true),
      body: ListView(
        children: [
          SubmitButton(
            onTap: () async {
              context.pushNamed(Names.addlead);
            },
            margin: 15,
            borderRadius: 6,
            lable: AppLocalizations.of(context)!.addLeads,
            icon: const Icon(
              Icons.add,
              color: AppColors.myWhite,
            ),
          ),
          const SizedBox(
            height: 4,
          ),
          BlocBuilder<MyleadsBloc, MyleadsState>(
            builder: (context, state) {
              if (state is MyleadsLoading) {
                return const LeadsCardShimmer();
              } else if (state is MyleadsLoaded) {
                if (state.leads.isNotEmpty) {
                  return ListView.builder(
                      physics: NeverScrollableScrollPhysics(),
                      padding: EdgeInsets.only(left: 16, right: 16, bottom: 16),
                      shrinkWrap: true,
                      itemCount: state.leads.length,
                      itemBuilder: (ctx, index) {
                        return MyLeadCard(
                          lead: state.leads[index],
                        );
                      });
                } else {
                  return Center(
                    child: Text(
                      "No Leads Available!",
                      style: AppTextStyles.style15w500(),
                    ),
                  );
                }
              } else {
                return SizedBox();
              }
            },
          ),
        ],
      ),
    );
  }
}
