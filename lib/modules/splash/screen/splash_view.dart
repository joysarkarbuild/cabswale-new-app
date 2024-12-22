import 'dart:io';
import 'package:cabswalle/constants/assets.dart';
import 'package:cabswalle/core/app_colors.dart';
import 'package:cabswalle/core/screen_responsive.dart';
import 'package:cabswalle/modules/splash/bloc/splash_bloc.dart';
import 'package:cabswalle/modules/splash/bloc/splash_event.dart';
import 'package:cabswalle/modules/splash/bloc/splash_state.dart';
import 'package:cabswalle/routes/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:lottie/lottie.dart';
import 'package:url_launcher/url_launcher.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();

    context.read<SplashBloc>().add(CheckAppVersionEvent());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.myprimaryColor,
      body: SizedBox(
        width: context.screenWidth,
        child: BlocConsumer<SplashBloc, SplashState>(
          listener: (context, state) {
            if (state is AppVersionMatched) {
              context.go(Routes.navbar); // Navigate to the next screen
            }
          },
          builder: (context, state) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  height: context.screenHeight * 0.6,
                  width: context.screenWidth * 0.6,
                  child: Image.asset(Assets.imagesCabIcon),
                ),
                if (state is AppVersionOutdated)
                  Column(
                    children: [
                      LottieBuilder.asset(Assets.animationsUpdate),
                      const Text(
                        "New update available!",
                        style: TextStyle(
                            fontSize: 26,
                            color: Colors.white,
                            fontWeight: FontWeight.w600),
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      SizedBox(
                        width: 200,
                        child: ElevatedButton(
                          onPressed: () async {
                            if (Platform.isAndroid) {
                              final Uri url =
                                  Uri.parse(state.appData.playStoreUrl);
                              if (await canLaunchUrl(url)) {
                                await launchUrl(url);
                              }
                            } else if (Platform.isIOS) {
                              final Uri url =
                                  Uri.parse(state.appData.appStoreUrl);
                              if (await canLaunchUrl(url)) {
                                await launchUrl(url);
                              }
                            }
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.green,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(2),
                            ),
                            minimumSize: Size(MediaQuery.of(context).size.width,
                                30), // Adjust the size as per your requirement
                            padding: const EdgeInsets.symmetric(
                                horizontal: 12,
                                vertical:
                                    6), // Adjust the padding as per your requirement
                          ),
                          child: const Text('Update Now',
                              style: TextStyle(color: Colors.white)),
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      if (!state.appData.forceUpdate)
                        TextButton(
                          onPressed: () {
                            context.go(Routes.navbar);
                          },
                          child: const Text(
                            "I will do it later",
                            style: TextStyle(color: Colors.amber),
                          ),
                        )
                    ],
                  )
              ],
            );
          },
        ),
      ),
    );
  }
}
