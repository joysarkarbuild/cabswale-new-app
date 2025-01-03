import 'package:cabswalle/constants/assets.dart';
import 'package:cabswalle/modules/topLocations/topDropLocations/top_drop_location.dart';
import 'package:cabswalle/modules/topLocations/topPickupLocation/top_pickup_location.dart';
import 'package:cabswalle/modules/topLocations/topRoutes/top_routes.dart';
import 'package:cabswalle/services/button_clicker_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class TopLocationsScreen extends StatefulWidget {
  const TopLocationsScreen({super.key});

  @override
  State<TopLocationsScreen> createState() => _TopLocationsScreenState();
}

class _TopLocationsScreenState extends State<TopLocationsScreen> {
  List options = [];
  @override
  void initState() {
    super.initState();
    options = [
      {
        "label": "Top Routes",
        "icon": Assets.iconsRoutes,
        "onTap": () {
          ButtonClickTracker.incrementTopRoutesClick();
          Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const TopRoutesScreen(),
              ));
        },
        "key": "routes"
      },
      {
        "label": "Top Pickup Locations",
        "icon": Assets.iconsPickup,
        "onTap": () {
          ButtonClickTracker.incrementTopPickupLocationsClick();
          Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const TopPickupLocationScreen(),
              ));
        },
        "key": "pickup"
      },
      {
        "label": "Top Drop Locations",
        "icon": Assets.iconsDrop,
        "onTap": () {
          ButtonClickTracker.incrementTopDropLocationsClick();
          Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const TopDropLocationScreen(),
              ));
        },
        "key": "drop"
      },
    ];
  }

  @override
  Widget build(BuildContext context) {
    const double itemHeight = 114;
    final double itemWidth = MediaQuery.of(context).size.width / 2;
    return Scaffold(
      appBar: AppBar(
        title: Text("Top Locations"),
        centerTitle: true,
      ),
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        padding: EdgeInsets.all(18),
        child: GridView.count(
          crossAxisCount: 2,
          childAspectRatio: itemWidth / itemHeight,
          crossAxisSpacing: 14,
          mainAxisSpacing: 14,
          children: [
            ...options.map((e) => InkWell(
                  onTap: e["onTap"],
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
                          e["icon"],
                          height: 40,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 5),
                          child: Text(
                            e["label"],
                            textAlign: TextAlign.center,
                            style: const TextStyle(fontSize: 16),
                          ),
                        )
                      ],
                    ),
                  ),
                ))
          ],
        ),
      ),
    );
  }
}
