import 'package:cabswalle/constants/assets.dart';
import 'package:cabswalle/modules/buySellCar/buy_sell_car_screen.dart';
import 'package:cabswalle/modules/earnMoney/earn_money_screen.dart';
import 'package:cabswalle/modules/insurance/insurance_screen1.dart';
import 'package:cabswalle/modules/jobs/jobs_screen.dart';
import 'package:cabswalle/modules/loan/screen/loan_screen.dart';
import 'package:cabswalle/modules/saveMoney/save_money_screen.dart';
import 'package:cabswalle/modules/services/bloc/services_bloc.dart';
import 'package:cabswalle/modules/services/bloc/services_event.dart';
import 'package:cabswalle/modules/services/bloc/services_state.dart';
import 'package:cabswalle/widgets/banner_widget.dart';
import 'package:cabswalle/widgets/centre_loading.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:url_launcher/url_launcher.dart';

class ServicesScreen extends StatefulWidget {
  const ServicesScreen({super.key});

  @override
  State<ServicesScreen> createState() => _ServicesScreenState();
}

class _ServicesScreenState extends State<ServicesScreen> {
  @override
  void initState() {
    context.read<ServicesBloc>().add(LoadServicesData());
    super.initState();
    _optionsList = [
      {
        "label": "Car Insurance",
        "icon": Assets.iconsCarInsurance,
        "onTap": () {
          Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => InsuranceScreen1(),
              ));
        },
        "key": "carInsurance"
      },
      {
        "label": "Loan",
        "icon": Assets.iconsLoan,
        "onTap": () {
          Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => LoanScreen(),
              ));
        },
        "key": "loan"
      },
      {
        "label": "Car Services",
        "icon": Assets.iconsCarRepair,
        "onTap": () {
          Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => SaveMoneyScreen(),
              ));
        },
        "key": "services"
      },
      {
        "label": "Jobs ",
        "icon": Assets.iconsJobSeeking,
        "onTap": () {
          Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => JobsScreen(),
              ));
        },
        "key": "jobs"
      },
      {
        "label": "Restaurants",
        "icon": Assets.iconsRestaurant,
        "onTap": () {
          Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => EarnMoneyScreen(),
              ));
        },
        "key": "extraIncome"
      },
      {
        "label": "Buy/Sell Cars",
        "icon": Assets.iconsSelling,
        "onTap": () {
          Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => BuyAndSellCarScreen(),
              ));
        },
        "key": "buySellCar"
      },
    ];
  }

  // Cached options list
  List<Map<String, dynamic>> _optionsList = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<ServicesBloc, ServicesState>(
        builder: (context, state) {
          if (state is ServicesLoading) {
            return const Center(child: CentreLoading());
          } else if (state is ServicesError) {
            return Center(child: Text(state.message));
          } else if (state is ServicesLoaded) {
            final options = _optionsList
                .where((option) => state.community[option["key"]] == true)
                .toList();

            return SafeArea(
              child: CustomScrollView(
                slivers: [
                  SliverToBoxAdapter(
                    child: Container(
                      height: 45,
                      margin: const EdgeInsets.only(
                        left: 16,
                        right: 16,
                        top: 10,
                      ),
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.blue),
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text(
                            "Wallet: ",
                            style: TextStyle(
                                fontSize: 18, fontWeight: FontWeight.w600),
                          ),
                          SvgPicture.asset(
                            Assets.iconsCabsCoin,
                            height: 18,
                          ),
                          Text(
                            " ${state.walletBalance} Cab Coins",
                            style: const TextStyle(
                                fontSize: 18, fontWeight: FontWeight.w600),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SliverToBoxAdapter(
                    child: Padding(
                      padding: const EdgeInsets.all(5.0),
                      child: BannerImage(
                        bannerId: "services",
                        onTap: () async {
                          launchUrl(Uri.parse("tel:+919403890306"));
                        },
                      ),
                    ),
                  ),
                  SliverPadding(
                    padding:
                        const EdgeInsets.only(left: 16, right: 16, bottom: 16),
                    sliver: SliverGrid(
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        childAspectRatio:
                            MediaQuery.of(context).size.width / 228,
                        crossAxisSpacing: 14,
                        mainAxisSpacing: 14,
                      ),
                      delegate: SliverChildBuilderDelegate((context, index) {
                        final option = options[index];
                        return InkWell(
                          onTap: () => option["onTap"](),
                          child: Container(
                            decoration: BoxDecoration(
                              border: Border.all(color: Colors.blue),
                              borderRadius: BorderRadius.circular(4),
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                SvgPicture.asset(
                                  option["icon"],
                                  height: 40,
                                ),
                                Text(
                                  option["label"],
                                  textAlign: TextAlign.center,
                                  style: const TextStyle(fontSize: 16),
                                ),
                              ],
                            ),
                          ),
                        );
                      }, childCount: options.length),
                    ),
                  ),
                ],
              ),
            );
          }
          return const SizedBox.shrink();
        },
      ),
    );
  }
}
