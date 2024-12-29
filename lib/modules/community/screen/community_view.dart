import 'package:cabswalle/constants/assets.dart';
import 'package:cabswalle/core/app_colors.dart';
import 'package:cabswalle/modules/community/bloc/community_bloc.dart';
import 'package:cabswalle/modules/community/bloc/community_event.dart';
import 'package:cabswalle/modules/community/bloc/community_state.dart';
import 'package:cabswalle/modules/driverList/screen/driver_list_view.dart';
import 'package:cabswalle/modules/emergency/screen/emergency_view.dart';
import 'package:cabswalle/modules/nearby/screen/nearby_view.dart';
import 'package:cabswalle/modules/partnerWithUs/screen/partner_with_us_view.dart';
import 'package:cabswalle/modules/referAndEarn/screen/refer_and_earn_view.dart';
import 'package:cabswalle/modules/reportProblem/screen/report_problem_view.dart';
import 'package:cabswalle/modules/topLocations/top_locations_screen.dart';
import 'package:cabswalle/modules/verifyAccount/screen/verify_account_view.dart';
import 'package:cabswalle/modules/videosFromRealDrivers/screen/videos_from_real_drivers_view.dart';
import 'package:cabswalle/widgets/centre_loading.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:url_launcher/url_launcher.dart';

class CommunityScreen extends StatefulWidget {
  const CommunityScreen({super.key});

  @override
  State<CommunityScreen> createState() => _CommunityScreenState();
}

class _CommunityScreenState extends State<CommunityScreen> {
  @override
  void initState() {
    context.read<CommunityBloc>().add(LoadServicesData());
    super.initState();
    options = [
      {
        "label": "Drivers List",
        "icon": Assets.iconsDriversList,
        "onTap": () {
          Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => DriverListScreen(),
              ));
        },
        "key": "driversList"
      },
      {
        "label": "Nearby",
        "icon": Assets.iconsNearby,
        "onTap": () {
          Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => NearbyScreen(),
              ));
        },
        "key": "nearby"
      },
      {
        "label": "Verify Account",
        "icon": Assets.iconsVerifyAccount,
        "onTap": () {
          Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => VerifyAccountScreen(
                  isFetchData: true,
                ),
              ));
        },
        "key": "profile"
      },
      {
        "label": "Top Locations",
        "icon": Assets.iconsTopLocations,
        "onTap": () {
          Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => TopLocationsScreen(),
              ));
        },
        "key": "topLocations"
      },
      {
        "label": "Emergency Numbers",
        "icon": Assets.iconsEmergency,
        "key": "emergency",
        "onTap": () {
          Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => EmergencyNumbers(),
              ));
        },
      },
      {
        "label": "Refer & Earn",
        "icon": Assets.iconsReferAndEarn,
        "key": "emergency",
        "onTap": () {
          Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => ReferScreen(),
              ));
        },
      },
      {
        "label": "Videos From Real Drivers",
        "icon": Assets.iconsVideos,
        "key": "videos",
        "onTap": () {
          Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => VideosFromRealDriversScreen(),
              ));
        },
      },
      {
        "label": "Partner With Us",
        "icon": Assets.iconsPartner,
        "key": "partner",
        "onTap": () {
          Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => PartnerWithUsScreen(),
              ));
        },
      },
    ];
  }

  List<Map<String, dynamic>> options = [];

  @override
  Widget build(BuildContext context) {
    const double itemHeight = 114;
    final double itemWidth = MediaQuery.of(context).size.width / 2;

    return Scaffold(
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            SliverPadding(
              padding: const EdgeInsets.all(10.0),
              sliver: BlocBuilder<CommunityBloc, CommunityState>(
                builder: (context, state) {
                  if (state is CommunityLoading) {
                    return SliverToBoxAdapter(child: CentreLoading());
                  }
                  if (state is CommunityError) {
                    return SliverToBoxAdapter(
                      child: Center(
                        child: Text(state.message),
                      ),
                    );
                  }
                  if (state is CommunityLoaded) {
                    final optionsList = options
                        .where(
                            (option) => state.community[option["key"]] == true)
                        .toList();
                    return SliverGrid(
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        childAspectRatio: itemWidth / itemHeight,
                        crossAxisSpacing: 14,
                        mainAxisSpacing: 14,
                      ),
                      delegate: SliverChildBuilderDelegate(
                        (context, index) {
                          final option = optionsList[index];
                          return InkWell(
                            onTap: option["onTap"],
                            child: Container(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 5),
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
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
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
                        childCount: optionsList.length,
                      ),
                    );
                  }
                  return SliverToBoxAdapter(
                    child: Center(
                      child: Text("Something Went Wrong!"),
                    ),
                  );
                },
              ),
            ),
            SliverToBoxAdapter(
              child: InkWell(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ReportProblemScreen(),
                      ));
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
