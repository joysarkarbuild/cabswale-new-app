import 'dart:convert';
import 'package:cabswalle/constants/assets.dart';
import 'package:cabswalle/core/screen_responsive.dart';
import 'package:cabswalle/modules/filterleads/screen/filterleads_view.dart';
import 'package:cabswalle/services/logger_service.dart';
import 'package:cabswalle/services/typesense_service.dart';
import 'package:cabswalle/widgets/centre_loading.dart';
import 'package:cabswalle/widgets/common_image_view.dart';
import 'package:cabswalle/widgets/common_widget_componants.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LocationScreen extends StatefulWidget {
  const LocationScreen({super.key});

  @override
  State<LocationScreen> createState() => _LocationScreenState();
}

class _LocationScreenState extends State<LocationScreen> {
  List<Map<String, dynamic>> cities = [];
  List<Map<String, dynamic>> pinnedCities = [];
  List<Map<String, dynamic>> searchCities = [];
  TextEditingController controller = TextEditingController();
  bool isLoading = true;
  final typesenseInstance = TypeSenseInstance();
  void getCities() async {
    LoggerService.logInfo("Getting Data from Cities Collection");
    await FirebaseFirestore.instance
        .collection("cities")
        .get()
        .then((value) async {
      final allData = value.docs.map((doc) => doc.data()).toList();
      cities = allData;

      cities.sort((a, b) => a["order"].compareTo(b["order"]));

      pinnedCities = await getPinnedCities();
    }).then((value) {
      setState(() {
        isLoading = false;
      });
    });
  }

  void savePinnedCities(List<Map<String, dynamic>> pinnedCities) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String jsonString = jsonEncode(pinnedCities);
    await prefs.setString('pinned_cities', jsonString);
  }

// Function to retrieve data from shared preferences
  Future<List<Map<String, dynamic>>> getPinnedCities() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? jsonString = prefs.getString('pinned_cities');
    if (jsonString != null) {
      List<dynamic> jsonList = jsonDecode(jsonString);
      List<Map<String, dynamic>> pinnedCities =
          jsonList.map((item) => item as Map<String, dynamic>).toList();
      return pinnedCities;
    } else {
      return [];
    }
  }

  @override
  void initState() {
    super.initState();

    getCities();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: myAppBar(
          context: context,
          title: "Locations",
          centerTitle: true,
        ),
        body: isLoading
            ? Center(
                child: CentreLoading(),
              )
            : Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: SizedBox(
                  width: MediaQuery.of(context).size.width,
                  height: context.screenHeight,
                  child: ListView(
                    children: [
                      const SizedBox(
                        height: 6,
                      ),
                      TextField(
                        controller: controller,
                        onChanged: (value) {
                          setState(() {
                            searchCities = cities
                                .where((element) => element["name"]
                                    .toString()
                                    .toLowerCase()
                                    .contains(value.toLowerCase()))
                                .toList();
                          });
                        },
                        decoration: const InputDecoration(
                          prefixIcon: Icon(Icons.search),
                          contentPadding:
                              EdgeInsets.only(left: 8, top: 2, bottom: 2),
                          border: OutlineInputBorder(),
                          hintText: 'Search location',
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      if (controller.text.isEmpty)
                        const Row(
                          children: [
                            Text(
                              "Pinned Locations",
                              style: TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.w800),
                            ),
                          ],
                        ),
                      const SizedBox(
                        height: 10,
                      ),
                      if (pinnedCities.isEmpty && controller.text.isEmpty)
                        const Text(
                          "No Pinned locations",
                          style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w800,
                              color: Colors.grey),
                        ),
                      if (controller.text.isEmpty)
                        ...pinnedCities.map((e) => Padding(
                              padding: const EdgeInsets.symmetric(vertical: 10),
                              child: InkWell(
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) =>
                                            FilterLeadsScreen(city: e["name"]),
                                      ));
                                },
                                child: Row(
                                  children: [
                                    if (e["img"] == "")
                                      ClipRRect(
                                        borderRadius: BorderRadius.circular(4),
                                        child: Image.asset(
                                          Assets.imagesDefaultCity,
                                          height: 50,
                                          width: 50,
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                    if (e["img"] != "")
                                      ClipRRect(
                                        borderRadius: BorderRadius.circular(4),
                                        child: CommonImageView(
                                          url: e["img"],
                                          height: 50,
                                          width: 50,
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                    const SizedBox(
                                      width: 14,
                                    ),
                                    Text(
                                      e["name"].toString().toUpperCase(),
                                      style: const TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.w500),
                                    ),
                                    const Spacer(),
                                    InkWell(
                                      onTap: () {
                                        setState(() {
                                          pinnedCities.removeWhere((element) =>
                                              element["name"] == e["name"]);
                                        });

                                        mySnackBar(context,
                                            '${e["name"]} revome from pinned cities');
                                      },
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: SvgPicture.asset(
                                          Assets.iconsPinFilled,
                                          height: 20,
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            )),
                      if (controller.text.isEmpty) Divider(),
                      const SizedBox(
                        height: 10,
                      ),
                      const Row(
                        children: [
                          Text(
                            "All Locations",
                            style: TextStyle(
                                fontSize: 18, fontWeight: FontWeight.w800),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      if (controller.text.isEmpty)
                        ...cities.map((e) => Padding(
                              padding: const EdgeInsets.symmetric(vertical: 10),
                              child: InkWell(
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) =>
                                            FilterLeadsScreen(city: e["name"]),
                                      ));
                                },
                                child: Row(
                                  children: [
                                    if (e["img"] == "")
                                      ClipRRect(
                                        borderRadius: BorderRadius.circular(4),
                                        child: Image.asset(
                                          Assets.imagesDefaultCity,
                                          height: 50,
                                          width: 50,
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                    if (e["img"] != "")
                                      ClipRRect(
                                        borderRadius: BorderRadius.circular(4),
                                        child: CommonImageView(
                                          url: e["img"],
                                          height: 50,
                                          width: 50,
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                    const SizedBox(
                                      width: 14,
                                    ),
                                    Text(
                                      e["name"].toString().toUpperCase(),
                                      style: const TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.w500),
                                    ),
                                    const Spacer(),
                                    InkWell(
                                      onTap: () {
                                        try {
                                          pinnedCities.firstWhere((element) =>
                                              element["name"] == e["name"]);
                                          mySnackBar(context,
                                              '${e["name"]} already pinned');
                                        } catch (err) {
                                          setState(() {
                                            pinnedCities.add(e);
                                          });
                                          savePinnedCities(pinnedCities);

                                          mySnackBar(context,
                                              '${e["name"]} added to pinned cities');
                                        }
                                      },
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: SvgPicture.asset(
                                          Assets.iconsPin,
                                          height: 20,
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            )),
                      if (controller.text.isNotEmpty)
                        ...searchCities.map((e) => Padding(
                              padding: const EdgeInsets.symmetric(vertical: 10),
                              child: InkWell(
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) =>
                                            FilterLeadsScreen(city: e["name"]),
                                      ));
                                },
                                child: Row(
                                  children: [
                                    if (e["img"] == "")
                                      ClipRRect(
                                        borderRadius: BorderRadius.circular(4),
                                        child: Image.asset(
                                          Assets.imagesDefaultCity,
                                          height: 50,
                                          width: 50,
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                    if (e["img"] != "")
                                      ClipRRect(
                                        borderRadius: BorderRadius.circular(4),
                                        child: CommonImageView(
                                          url: e["img"],
                                          height: 50,
                                          width: 50,
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                    const SizedBox(
                                      width: 14,
                                    ),
                                    Text(
                                      e["name"].toString().toUpperCase(),
                                      style: const TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.w500),
                                    ),
                                    const Spacer(),
                                    InkWell(
                                      onTap: () {
                                        try {
                                          pinnedCities.firstWhere((element) =>
                                              element["name"] == e["name"]);
                                          mySnackBar(context,
                                              '${e["name"]} already pinned');
                                        } catch (err) {
                                          setState(() {
                                            pinnedCities.add(e);
                                          });
                                          savePinnedCities(pinnedCities);

                                          mySnackBar(context,
                                              '${e["name"]} added to pinned cities');
                                        }
                                      },
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: SvgPicture.asset(
                                          Assets.iconsPin,
                                          height: 20,
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            )),
                      const SizedBox(
                        height: 30,
                      ),
                    ],
                  ),
                ),
              ));
  }
}
