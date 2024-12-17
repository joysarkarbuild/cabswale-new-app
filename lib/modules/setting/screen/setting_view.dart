import 'package:cabswalle/services/driver_service.dart';
import 'package:cabswalle/services/location_service.dart';
import 'package:cabswalle/widgets/common_widget_componants.dart';
import 'package:flutter/material.dart';

class SettingScreen extends StatefulWidget {
  const SettingScreen({super.key});

  @override
  State<SettingScreen> createState() => _SettingScreenState();
}

class _SettingScreenState extends State<SettingScreen> {
  final LocationService locationService = LocationService();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: myAppBar(context: context, title: "Settings", centerTitle: true),
      body: Column(
        children: [
          SizedBox(
            height: 20,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 26, top: 16, right: 14),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Location',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
                ),
                SizedBox(
                  height: 35,
                  child: FittedBox(
                    child: Switch(
                        value: locationService.locationUpdateOn ?? true,
                        onChanged: (bool value) {
                          setState(() {
                            locationService.locationUpdateOnOff(value);
                          });
                        }),
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 26, top: 24, right: 14),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Notifications',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
                ),
                SizedBox(
                  height: 35,
                  child: FittedBox(
                    child: Switch(
                        value: DriverService
                            .instance.driverModel!.notificationAlert!,
                        onChanged: (bool value) async {
                          await DriverService.instance
                              .updateDriverField("notificationAlert", value);

                          setState(() {});
                        }),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
