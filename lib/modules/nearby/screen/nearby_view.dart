import 'package:cabswalle/constants/assets.dart';
import 'package:cabswalle/modules/community/bloc/community_bloc.dart';
import 'package:cabswalle/modules/community/bloc/community_state.dart';
import 'package:cabswalle/routes/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';

class NearbyScreen extends StatefulWidget {
  const NearbyScreen({super.key});

  @override
  State<NearbyScreen> createState() => _NearbyScreenState();
}

class _NearbyScreenState extends State<NearbyScreen> {
  List options = [];

  @override
  void initState() {
    super.initState();
    options = [
      {
        "label": "Cabswale Drivers",
        "icon": Assets.iconsNearby,
        "onTap": () {
          context.pushNamed(Names.nearbyDriver);
        },
        "key": "nearby"
      },
      {
        "label": "Petrol/CNG Pumps",
        "icon": Assets.iconsPetrol,
        "key": "petrolCng",
        "onTap": () {
          context.pushNamed(Names.nearbyPlace,
              extra: "Petrol/CNG Pumps Near me");
        },
      },
      {
        "label": "Car Repair Shops",
        "icon": Assets.iconsCarRepair,
        "key": "carRepair",
        "onTap": () {
          context.pushNamed(Names.nearbyPlace,
              extra: "Car Repair Shops near me");
        },
      },
      {
        "label": "Towing Service",
        "icon": Assets.iconsTowing,
        "key": "towing",
        "onTap": () {
          context.pushNamed(Names.nearbyPlace, extra: "Towing Service Near me");
        },
      },
      {
        "label": "Auto Part Stores",
        "icon": Assets.iconsStore,
        "key": "autoparts",
        "onTap": () {
          context.pushNamed(Names.nearbyPlace,
              extra: "Auto Part Stores Near me");
        },
      },
      {
        "label": "Service Stations",
        "icon": Assets.iconsCarWash,
        "key": "service",
        "onTap": () {
          context.pushNamed(Names.nearbyPlace,
              extra: "Service Stations Near me");
        },
      },
    ];
  }

  @override
  Widget build(BuildContext context) {
    const double itemHeight = 134;
    final double itemWidth = MediaQuery.of(context).size.width / 2;
    final optionsList = options
        .where((option) =>
            (context.read<CommunityBloc>().state as CommunityLoaded)
                .community[option["key"]] ==
            true)
        .toList();
    return Scaffold(
      appBar: AppBar(
        title: const Text("Nearby"),
        centerTitle: true,
      ),
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        padding: const EdgeInsets.all(18),
        child: GridView.count(
          crossAxisCount: 2,
          childAspectRatio: itemWidth / itemHeight,
          crossAxisSpacing: 14,
          mainAxisSpacing: 14,
          children: optionsList.map((e) {
            return InkWell(
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
                        "${e["label"]}",
                        textAlign: TextAlign.center,
                        style: const TextStyle(fontSize: 16),
                      ),
                    ),
                  ],
                ),
              ),
            );
          }).toList(),
        ),
      ),
    );
  }
}
