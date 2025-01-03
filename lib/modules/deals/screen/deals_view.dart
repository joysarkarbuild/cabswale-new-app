import 'package:cabswalle/constants/assets.dart';
import 'package:cabswalle/modules/deals/bloc/deals_bloc.dart';
import 'package:cabswalle/modules/deals/bloc/deals_event.dart';
import 'package:cabswalle/modules/deals/bloc/deals_state.dart';
import 'package:cabswalle/modules/deals/screen/callls_screen.dart';
import 'package:cabswalle/modules/deals/screen/deals_confirmation_screen.dart';
import 'package:cabswalle/routes/app_routes.dart';
import 'package:cabswalle/services/button_clicker_service.dart';
import 'package:cabswalle/services/driver_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';

class DealsScreen extends StatelessWidget {
  const DealsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    context.read<DealsBloc>().add(FetchDealsData());
    return Scaffold(
      body: SafeArea(
        child: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          padding: const EdgeInsets.all(12),
          child: Column(
            children: [
              const SizedBox(
                height: 28,
              ),
              BlocBuilder<DealsBloc, DealsState>(
                builder: (context, state) {
                  if (state is DealsLoading) {
                    return Container(
                      height: 100,
                      width: MediaQuery.of(context).size.width,
                      decoration: BoxDecoration(
                          border: Border.all(color: Colors.blue),
                          borderRadius: BorderRadius.circular(6),
                          color: Colors.blue.withValues(alpha: 0.1)),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          SizedBox(
                            width: MediaQuery.of(context).size.width * 0.3,
                            height: 100,
                            child: const Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  "Calls",
                                  style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.w600),
                                ),
                                Text(
                                  "0",
                                  style: TextStyle(
                                      fontSize: 22,
                                      fontWeight: FontWeight.w400),
                                )
                              ],
                            ),
                          ),
                          Container(
                            height: 100,
                            width: 1,
                            decoration: const BoxDecoration(color: Colors.blue),
                          ),
                          SizedBox(
                            width: MediaQuery.of(context).size.width * 0.3,
                            height: 100,
                            child: const Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  "Deals",
                                  style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.w600),
                                ),
                                Text(
                                  "0",
                                  style: TextStyle(
                                      fontSize: 22,
                                      fontWeight: FontWeight.w400),
                                )
                              ],
                            ),
                          ),
                          Container(
                            height: 100,
                            width: 1,
                            decoration: const BoxDecoration(color: Colors.blue),
                          ),
                          SizedBox(
                            width: MediaQuery.of(context).size.width * 0.3,
                            height: 100,
                            child: const Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  "Leads",
                                  style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.w600),
                                ),
                                Text(
                                  "0",
                                  style: TextStyle(
                                      fontSize: 22,
                                      fontWeight: FontWeight.w400),
                                )
                              ],
                            ),
                          ),
                        ],
                      ),
                    );
                  }
                  if (state is DealsLoaded) {
                    return Container(
                      height: 100,
                      width: MediaQuery.of(context).size.width,
                      decoration: BoxDecoration(
                          border: Border.all(color: Colors.blue),
                          borderRadius: BorderRadius.circular(6),
                          color: Colors.blue.withValues(alpha: 0.1)),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          SizedBox(
                            width: MediaQuery.of(context).size.width * 0.3,
                            height: 100,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  "Calls",
                                  style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.w600),
                                ),
                                Text(
                                  "${state.data["outgoingCalls"]}",
                                  style: TextStyle(
                                      fontSize: 22,
                                      fontWeight: FontWeight.w400),
                                )
                              ],
                            ),
                          ),
                          Container(
                            height: 100,
                            width: 1,
                            decoration: const BoxDecoration(color: Colors.blue),
                          ),
                          SizedBox(
                            width: MediaQuery.of(context).size.width * 0.3,
                            height: 100,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  "Deals",
                                  style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.w600),
                                ),
                                Text(
                                  "${DriverService.instance.driverModel!.dealCount}",
                                  style: TextStyle(
                                      fontSize: 22,
                                      fontWeight: FontWeight.w400),
                                )
                              ],
                            ),
                          ),
                          Container(
                            height: 100,
                            width: 1,
                            decoration: const BoxDecoration(color: Colors.blue),
                          ),
                          SizedBox(
                            width: MediaQuery.of(context).size.width * 0.3,
                            height: 100,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  "Leads",
                                  style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.w600),
                                ),
                                Text(
                                  "${DriverService.instance.driverModel!.totalLeads}",
                                  style: TextStyle(
                                      fontSize: 22,
                                      fontWeight: FontWeight.w400),
                                )
                              ],
                            ),
                          ),
                        ],
                      ),
                    );
                  }

                  return Text("Something Went Wrong!");
                },
              ),
              const SizedBox(
                height: 30,
              ),
              InkWell(
                onTap: () {
                  ButtonClickTracker.incrementDeals();
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => DealsConfirmationScreen(),
                      ));
                },
                child: Container(
                  height: 70,
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.green.withValues(alpha: 0.15),
                      border: Border.all(
                        color: Colors.blue,
                      )),
                  padding: const EdgeInsets.symmetric(horizontal: 30),
                  child: Row(
                    children: [
                      SvgPicture.asset(
                        Assets.iconsDealMain,
                        height: 40,
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      const Text(
                        "Deals",
                        style: TextStyle(
                            fontSize: 28, fontWeight: FontWeight.w700),
                      )
                    ],
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              InkWell(
                onTap: () {
                  ButtonClickTracker.incrementCallsTabClick();
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => CallHistoryScreen(),
                      ));
                },
                child: Container(
                  height: 70,
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.purple.withValues(alpha: 0.15),
                      border: Border.all(
                        color: Colors.blue,
                      )),
                  padding: const EdgeInsets.symmetric(horizontal: 30),
                  child: Row(
                    children: [
                      SvgPicture.asset(
                        Assets.iconsCalls,
                        height: 36,
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      const Text(
                        "Calls",
                        style: TextStyle(
                            fontSize: 28, fontWeight: FontWeight.w700),
                      )
                    ],
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              InkWell(
                onTap: () {
                  ButtonClickTracker.incrementMyLeadsClick();
                  context.pushNamed(Names.myleads);
                },
                child: Container(
                  height: 70,
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.tealAccent.withValues(alpha: 0.15),
                      border: Border.all(
                        color: Colors.blue,
                      )),
                  padding: const EdgeInsets.symmetric(horizontal: 30),
                  child: Row(
                    children: [
                      SvgPicture.asset(
                        Assets.iconsMyLead,
                        height: 33,
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      const Text(
                        "My Leads",
                        style: TextStyle(
                            fontSize: 28, fontWeight: FontWeight.w700),
                      )
                    ],
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              InkWell(
                onTap: () {
                  ButtonClickTracker.incrementAddLeadsClick();
                  context.pushNamed(Names.addlead);
                },
                child: Container(
                  height: 70,
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.green.withValues(alpha: 0.15),
                      border: Border.all(
                        color: Colors.blue,
                      )),
                  padding: const EdgeInsets.symmetric(horizontal: 30),
                  child: Row(
                    children: [
                      SvgPicture.asset(
                        Assets.iconsAddLeads,
                        height: 40,
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      const Text(
                        "Add Leads",
                        style: TextStyle(
                            fontSize: 28, fontWeight: FontWeight.w700),
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
