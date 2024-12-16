import 'dart:async';

import 'package:cabswalle/app.dart';
import 'package:cabswalle/constants/assets.dart';
import 'package:cabswalle/modules/filterleads/bloc/filterleads_bloc.dart';
import 'package:cabswalle/modules/filterleads/bloc/filterleads_event.dart';
import 'package:cabswalle/modules/filterleads/bloc/filterleads_state.dart';
import 'package:cabswalle/modules/filterleads/screen/widgets/scrolling_text.dart';
import 'package:cabswalle/services/driver_service.dart';
import 'package:cabswalle/services/login_manager.dart';
import 'package:cabswalle/widgets/centre_loading.dart';
import 'package:cabswalle/widgets/common_widget_componants.dart';
import 'package:cabswalle/widgets/lead_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FilterLeadsScreen extends StatefulWidget {
  const FilterLeadsScreen({
    super.key,
    required this.city,
  });

  final String city;

  @override
  State<FilterLeadsScreen> createState() => _FilterLeadsScreenState();
}

class _FilterLeadsScreenState extends State<FilterLeadsScreen> {
  late Timer _timer;
  @override
  void initState() {
    super.initState();
    if (widget.city.isNotEmpty) {
      context
          .read<FilterleadsBloc>()
          .add(FetchLeadInitEvent(city: widget.city));
      _timer = Timer.periodic(const Duration(seconds: 20), (timer) {
        context
            .read<FilterleadsBloc>()
            .add(FetchLeadMoreEvent(city: widget.city));
      });
    } else {
      context.read<FilterleadsBloc>().add(FetchLeadInitMyLocationLeadsEvent());
      _timer = Timer.periodic(const Duration(seconds: 20), (timer) {
        context
            .read<FilterleadsBloc>()
            .add(FetchLeadMoreMyLocationLeadsEvent());
      });
    }
  }

  @override
  void dispose() {
    // Cancel the timer when the widget is disposed to avoid memory leaks
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: myAppBar(
          context: context,
          title: widget.city.isNotEmpty
              ? "Leads from ${widget.city}"
              : "Duties at your Location",
          centerTitle: widget.city.isNotEmpty,
        ),
        body: RefreshIndicator(
          onRefresh: () async {
            context
                .read<FilterleadsBloc>()
                .add(FetchLeadInitEvent(city: widget.city));
          },
          child: BlocBuilder<FilterleadsBloc, FilterleadsState>(
            builder: (context, state) {
              if (state is FilterLeadLoading) {
                return CentreLoading();
              } else if (state is FilterLeadLoaded) {
                return ListView.builder(
                  itemCount: state.leads.length,
                  itemBuilder: (context, index) => Column(
                    children: [
                      if (index == 0)
                        Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(
                                top: 10,
                                bottom: 10,
                              ),
                              child: Image.asset(
                                Assets.imagesLoading,
                                width: MediaQuery.of(context).size.width,
                              ),
                            ),
                            if (LoginManager.isLogin &&
                                DriverService.instance.driverModel != null &&
                                !(DriverService
                                    .instance.driverModel!.membership!.active))
                              Container(
                                width: MediaQuery.of(context).size.width,
                                height: 80,
                                decoration: BoxDecoration(
                                    color: Colors.red.withValues(alpha: 0.4)),
                                child: Column(
                                  children: [
                                    const SizedBox(
                                      height: 2,
                                    ),
                                    Container(
                                      padding: const EdgeInsets.only(
                                          left: 10, right: 10),
                                      width: MediaQuery.of(context).size.width,
                                      height: 30,
                                      child: const ScrollingText(
                                        text:
                                            "Please recharge now. You may miss your duty as recharge might take 5-10 mins.     कृपया अभी रिचार्ज करें. आपकी ड्यूटी छूट सकती है क्योंकि रिचार्ज में 5-10 मिनट लग सकते हैं।      Kirapā karakē huṇē rīcāraja karō. Tusīṁ āpaṇī ḍi’ūṭī gu’ā sakadē hō ki’uṅki rīcāraja vica 5-10 miṭa laga sakadē hana.      ",
                                        ratioOfBlankToScreen: 0,
                                        scrollAxis: Axis.horizontal,
                                        textStyle: TextStyle(
                                            fontSize: 20,
                                            fontWeight: FontWeight.w500),
                                      ),
                                    ),
                                    ElevatedButton(
                                      onPressed: () {},
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor: Colors.green,
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(2),
                                        ),
                                        minimumSize: const Size(100,
                                            30), // Adjust the size as per your requirement
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 12,
                                            vertical:
                                                6), // Adjust the padding as per your requirement
                                      ),
                                      child: const Text('Recharge Now',
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 13)),
                                    )
                                  ],
                                ),
                              ),
                            const SizedBox(
                              height: 8,
                            )
                          ],
                        ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        child: LeadsCard(lead: state.leads[index]),
                      ),
                    ],
                  ),
                );
              } else {
                return Center(
                  child: Text("Something went wrong!"),
                );
              }
            },
          ),
        ));
  }
}
