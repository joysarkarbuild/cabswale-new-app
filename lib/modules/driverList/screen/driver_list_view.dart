import 'package:cabswalle/core/app_colors.dart';
import 'package:cabswalle/core/app_text_styles.dart';
import 'package:cabswalle/core/screen_responsive.dart';
import 'package:cabswalle/modules/driverList/bloc/driver_list_bloc.dart';
import 'package:cabswalle/modules/driverList/bloc/driver_list_event.dart';
import 'package:cabswalle/modules/driverList/bloc/driver_list_state.dart';
import 'package:cabswalle/modules/verifyAccount/screen/verify_account_view.dart';
import 'package:cabswalle/services/driver_service.dart';
import 'package:cabswalle/widgets/centre_loading.dart';
import 'package:cabswalle/widgets/common_widget_componants.dart';
import 'package:cabswalle/widgets/driver_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DriverListScreen extends StatefulWidget {
  const DriverListScreen({super.key});

  @override
  State<DriverListScreen> createState() => _DriverListScreenState();
}

class _DriverListScreenState extends State<DriverListScreen> {
  String selectedOption = "verified";
  int page = 1;

  @override
  void initState() {
    context.read<DriverListBloc>().add(FetchDrivers(type: "verified"));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: myAppBar(
          context: context,
          centerTitle: true,
          title: "Drivers",
        ),
        body: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  InkWell(
                    onTap: () {
                      setState(() {
                        selectedOption = "verified";
                      });
                      context
                          .read<DriverListBloc>()
                          .add(FetchDrivers(type: selectedOption));
                    },
                    child: Container(
                      height: 30,
                      width: MediaQuery.of(context).size.width * 0.3,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(4),
                          border: Border.all(color: Colors.green),
                          color: selectedOption == "verified"
                              ? Colors.green.withValues(alpha: 0.3)
                              : Colors.transparent),
                      child: const Center(
                        child: Text("Verified"),
                      ),
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      setState(() {
                        selectedOption = "fraud";
                      });

                      context
                          .read<DriverListBloc>()
                          .add(FetchDrivers(type: selectedOption));
                    },
                    child: Container(
                      height: 30,
                      width: MediaQuery.of(context).size.width * 0.3,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(4),
                          border: Border.all(color: Colors.red),
                          color: selectedOption == "fraud"
                              ? Colors.red.withValues(alpha: 0.3)
                              : Colors.transparent),
                      child: const Center(
                        child: Text("Fraud"),
                      ),
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      setState(() {
                        selectedOption = "notVerified";
                      });

                      context
                          .read<DriverListBloc>()
                          .add(FetchDrivers(type: selectedOption));
                    },
                    child: Container(
                      height: 30,
                      width: MediaQuery.of(context).size.width * 0.3,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(4),
                          border: Border.all(color: Colors.blue),
                          color: selectedOption == "notVerified"
                              ? Colors.blue.withValues(alpha: 0.3)
                              : Colors.transparent),
                      child: const Center(
                        child: Text("Not verified"),
                      ),
                    ),
                  )
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
              child: Container(
                padding: EdgeInsets.only(top: 3),
                height: 50,
                decoration: BoxDecoration(
                    border: Border.all(color: AppColors.myBlack45),
                    borderRadius: BorderRadius.circular(6)),
                child: TextFormField(
                  decoration: InputDecoration(
                    prefixIcon: Icon(
                      Icons.search,
                      color: AppColors.myBlack45,
                    ),
                    hintText: "Search Name/Phone Number",
                    hintStyle: AppTextStyles.style15w400(),
                    border: InputBorder.none,
                  ),
                  onChanged: (value) async {
                    // Call filterDrivers method of provider with the search query
                    String finalVal = "";
                    if (value.length == 10) {
                      try {
                        int.parse(value);
                        finalVal = "+91$value";
                      } catch (e) {
                        finalVal = value;
                      }
                    } else {
                      finalVal = value;
                    }
                  },
                ),
              ),
            ),
            if (DriverService.instance.driverModel != null &&
                !DriverService.instance.driverModel!.verified)
              Padding(
                padding: const EdgeInsets.only(left: 10, right: 10),
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green.withValues(alpha: 0.9),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(4),
                    ),
                    minimumSize: const Size(
                        140, 30), // Adjust the size as per your requirement
                    padding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical:
                            6), // Adjust the padding as per your requirement
                  ),
                  child: const Text(
                    'Verify My Profile',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 14,
                        fontWeight: FontWeight.w500),
                  ),
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const VerifyAccountScreen(
                            isFetchData: true,
                          ),
                        ));
                  },
                ),
              ),
            BlocBuilder<DriverListBloc, DriverListState>(
              builder: (context, state) {
                if (state is DriverLoading) {
                  return CentreLoading();
                }
                if (state is DriverLoaded) {
                  return SizedBox(
                    width: context.screenWidth,
                    height: context.screenHeight - 265,
                    child: ListView.builder(
                      itemCount: state.drivers.length,
                      itemBuilder: (context, index) => Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        child: VerifiedDriversCard(
                          verifiedDriver: state.drivers[index],
                          selectedOption: selectedOption,
                        ),
                      ),
                    ),
                  );
                } else {
                  return Center(
                    child: Text("Something Went Wrong!"),
                  );
                }
              },
            ),
          ],
        ));
  }
}
