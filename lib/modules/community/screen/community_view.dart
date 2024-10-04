import 'package:cabswalle/constants/assets.dart';
import 'package:cabswalle/core/app_colors.dart';
import 'package:cabswalle/routes/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:url_launcher/url_launcher.dart';

class CommunityScreen extends StatelessWidget {
  const CommunityScreen({super.key});

  @override
  Widget build(BuildContext context) {
    const double itemHeight = 114;
    final double itemWidth = MediaQuery.of(context).size.width / 2;
    final List<Map<String, dynamic>> options = [
      {
        "label": "Wallet",
        "icon": Assets.iconsWallet,
        "onTap": () {
          context.pushNamed(Names.wallet);
        },
        "key": "wallet"
      },
      {
        "label": "Extra Benefits",
        "icon": Assets.iconsOffer,
        "onTap": () {
          context.pushNamed(Names.extraBenifits);
        },
        "key": "extraIncome"
      },
      {
        "label": "Loan",
        "icon": Assets.iconsLoan,
        "onTap": () {
          context.pushNamed(Names.loan);
        },
        "key": "loan"
      },
      {
        "label": "Drivers List",
        "icon": Assets.iconsDriversList,
        "onTap": () {},
        "key": "driversList"
      },
      {
        "label": "Nearby",
        "icon": Assets.iconsNearby,
        "onTap": () {
          context.pushNamed(Names.nearby);
        },
        "key": "nearby"
      },
      {
        "label": "Verify Account",
        "icon": Assets.iconsVerifyAccount,
        "onTap": () {
          context.pushNamed(Names.verifyAccount);
        },
        "key": "profile"
      },
      {
        "label": "Connections",
        "icon": Assets.iconsConnections,
        "onTap": () {},
        "key": "connections"
      },
      {
        "label": "Top Locations",
        "icon": Assets.iconsTopLocations,
        "onTap": () {
          context.pushNamed(Names.topLocations);
        },
        "key": "topLocations"
      },
      {
        "label": "Emergency Numbers",
        "icon": Assets.iconsEmergency,
        "key": "emergency",
        "onTap": () {
          context.pushNamed(Names.emergency);
        },
      },
      {
        "label": "Refer & Earn",
        "icon": Assets.iconsReferAndEarn,
        "key": "emergency",
        "onTap": () {
          context.pushNamed(Names.referAndEarn);
        },
      },
      {
        "label": "Videos From Real Drivers",
        "icon": Assets.iconsVideos,
        "key": "videos",
        "onTap": () {
          context.pushNamed(Names.videosFromRealDrivers);
        },
      },
      {
        "label": "Partner With Us",
        "icon": Assets.iconsPartner,
        "key": "partner",
        "onTap": () {
          context.pushNamed(Names.partnerWithUs);
        },
      },
    ];

    final List<Map<String, dynamic>> filteredOptions = options.toList();

    return Scaffold(
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            SliverPadding(
              padding: const EdgeInsets.all(10.0),
              sliver: SliverGrid(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio: itemWidth / itemHeight,
                  crossAxisSpacing: 14,
                  mainAxisSpacing: 14,
                ),
                delegate: SliverChildBuilderDelegate(
                  (context, index) {
                    final option = filteredOptions[index];
                    return InkWell(
                      onTap: option["onTap"],
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 5),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(4),
                          border: Border.all(color: Colors.blue),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SvgPicture.asset(
                              option["icon"],
                              height: 40,
                            ),
                            if (option["key"] == "wallet")
                              Padding(
                                padding: const EdgeInsets.only(top: 5),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    const Text(
                                      "Wallet (",
                                      textAlign: TextAlign.center,
                                      style: TextStyle(fontSize: 16),
                                    ),
                                    SvgPicture.asset(
                                      Assets.iconsCabsCoin,
                                      height: 15,
                                    ),
                                    const Text(
                                      "${200})",
                                      textAlign: TextAlign.center,
                                      style: TextStyle(fontSize: 16),
                                    ),
                                  ],
                                ),
                              ),
                            if (option["key"] != "wallet")
                              Padding(
                                padding: const EdgeInsets.only(top: 5),
                                child: Text(
                                  option["label"],
                                  textAlign: TextAlign.center,
                                  style: const TextStyle(fontSize: 16),
                                ),
                              )
                          ],
                        ),
                      ),
                    );
                  },
                  childCount: filteredOptions.length,
                ),
              ),
            ),
            SliverToBoxAdapter(
              child: InkWell(
                onTap: () {
                  context.pushNamed(Names.reportProblem);
                },
                child: Container(
                  height: 110,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 20,
                  ),
                  margin: const EdgeInsets.only(
                      left: 10, right: 10, bottom: 20, top: 4),
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                      border: Border.all(color: Colors.blue),
                      borderRadius: BorderRadius.circular(4)),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SvgPicture.asset(
                            Assets.iconsProblem,
                            height: 40,
                          ),
                          const Padding(
                            padding: EdgeInsets.only(top: 5),
                            child: Text(
                              "Tell Us Your\nProblems",
                              textAlign: TextAlign.center,
                              style: TextStyle(fontSize: 16),
                            ),
                          )
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: ElevatedButton(
                  onPressed: () async {
                    launchUrl(Uri.parse("tel:+919403890306"));
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.myBlue,
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
                  child: const Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.phone,
                        color: Colors.white,
                      ),
                      SizedBox(
                        width: 8,
                      ),
                      Text('Call Cabswalle',
                          style: TextStyle(color: Colors.white)),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
