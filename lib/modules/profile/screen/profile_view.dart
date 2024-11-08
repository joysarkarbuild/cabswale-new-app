import 'package:cabswalle/constants/assets.dart';
import 'package:cabswalle/core/app_text_styles.dart';
import 'package:cabswalle/core/screen_responsive.dart';
import 'package:cabswalle/modules/splash/bloc/splash_bloc.dart';
import 'package:cabswalle/modules/splash/bloc/splash_state.dart';
import 'package:cabswalle/routes/app_routes.dart';
import 'package:cabswalle/widgets/common_widget_componants.dart';
import 'package:cabswalle/widgets/profile_option_card.dart';
import 'package:cabswalle/widgets/submit_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:go_router/go_router.dart';
import 'package:url_launcher/url_launcher.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          bottom: PreferredSize(
              preferredSize: Size(context.screenWidth, 24),
              child: Column(
                children: [
                  Text(
                    'Joy Sarkar',
                    style: AppTextStyles.style22w600(),
                  ),
                  SizedBox(
                    height: 8,
                  ),
                  Image.asset(
                    Assets.imagesVe,
                    height: 20,
                  ),
                ],
              )),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              children: [
                ProfileOptionCard(
                    icon: Assets.iconsProfile,
                    onTap: () {
                      context.pushNamed(Names.myprofile);
                    },
                    title: AppLocalizations.of(context)!.profileInfo),
                ProfileOptionCard(
                    icon: Assets.iconsMembership,
                    onTap: () {},
                    title: "Cabswale Membership"),
                ProfileOptionCard(
                    icon: Assets.iconsTransactions,
                    onTap: () {},
                    title: "Wallet Transactions"),
                ProfileOptionCard(
                    icon: Assets.iconsAlerts, onTap: () {}, title: "My Alerts"),
                ProfileOptionCard(
                    icon: Assets.iconsLanguage,
                    onTap: () {},
                    title: "Change Language"),
                ProfileOptionCard(
                    icon: Assets.iconsSettings,
                    onTap: () {},
                    title: "Settings"),
                BlocBuilder<SplashBloc, SplashState>(
                  builder: (context, state) {
                    return ProfileOptionCard(
                        icon: Assets.iconsTermsAndConditions,
                        onTap: () {
                          if (state is AppVersionMatched) {
                            launchUrl(Uri.parse(state.privacyUrl));
                          }
                        },
                        title: "Terms and Policy");
                  },
                ),
                ProfileOptionCard(
                    icon: Assets.iconsLogout,
                    onTap: () {
                      showMyDialoge(
                          context: context,
                          onYes: () {},
                          content: Text(
                            AppLocalizations.of(context)!.wanttoLogout,
                          ));
                    },
                    title: AppLocalizations.of(context)!.logout),
                ProfileOptionCard(
                    icon: Assets.iconsDelete,
                    onTap: () {
                      showMyDialoge(
                          context: context,
                          onYes: () {},
                          content: Text(
                            AppLocalizations.of(context)!.deleteWarning,
                          ));
                    },
                    title: "Delete Account"),
                SizedBox(
                  height: 20,
                ),
                SubmitButton(
                  onTap: () {},
                  lable: "Call Cabswale",
                  height: 40,
                  borderRadius: 5,
                ),
                SizedBox(
                  height: 20,
                ),
              ],
            ),
          ),
        ));
  }
}
