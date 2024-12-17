import 'package:cabswalle/constants/assets.dart';
import 'package:cabswalle/core/app_text_styles.dart';
import 'package:cabswalle/core/screen_responsive.dart';
import 'package:cabswalle/modules/splash/bloc/splash_bloc.dart';
import 'package:cabswalle/modules/splash/bloc/splash_state.dart';
import 'package:cabswalle/routes/app_routes.dart';
import 'package:cabswalle/services/driver_service.dart';
import 'package:cabswalle/services/loading_overlay_service.dart';
import 'package:cabswalle/services/login_manager.dart';
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
              preferredSize: Size(context.screenWidth, 6),
              child: Column(
                children: [
                  Text(
                    DriverService.instance.driverModel!.name ??
                        "Cabswale Partner",
                    style: AppTextStyles.style22w600(),
                  ),
                  SizedBox(
                    height: 8,
                  ),
                  Image.asset(
                    Assets.imagesVe,
                    height: 20,
                  ),
                  SizedBox(
                    height: 8,
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
                    onTap: () {
                      context.pushNamed(Names.walletTransactions);
                    },
                    title: "Wallet Transactions"),
                // ProfileOptionCard(
                //     icon: Assets.iconsAlerts, onTap: () {}, title: "My Alerts"),
                ProfileOptionCard(
                    icon: Assets.iconsLanguage,
                    onTap: () {
                      context.pushNamed(Names.language);
                    },
                    title: "Change Language"),
                ProfileOptionCard(
                    icon: Assets.iconsSettings,
                    onTap: () {
                      context.pushNamed(Names.settings);
                    },
                    title: "Settings"),
                BlocBuilder<SplashBloc, SplashState>(
                  builder: (context, state) {
                    return ProfileOptionCard(
                        icon: Assets.iconsTermsAndConditions,
                        onTap: () {
                          if (state is AppVersionMatched) {
                            launchUrl(Uri.parse(state.appData.policy));
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
                          onYes: () async {
                            LoadingOverlay().show(context);
                            LoginManager loginManager = LoginManager();
                            await loginManager.logout();
                            LoadingOverlay().hide();
                            // ignore: use_build_context_synchronously
                            context.pop();
                            // ignore: use_build_context_synchronously
                            context.goNamed(Names.login);
                          },
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
                          onYes: () async {
                            LoadingOverlay().show(context);
                            LoginManager loginManager = LoginManager();
                            await loginManager.deleteAccount();
                            LoadingOverlay().hide();
                            // ignore: use_build_context_synchronously
                            context.pop();
                            // ignore: use_build_context_synchronously
                            context.goNamed(Names.login);
                          },
                          content: Text(
                            AppLocalizations.of(context)!.deleteWarning,
                          ));
                    },
                    title: "Delete Account"),
                SizedBox(
                  height: 20,
                ),
                SubmitButton(
                  onTap: () {
                    launchUrl(Uri.parse("tel:+919403890306"));
                  },
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
