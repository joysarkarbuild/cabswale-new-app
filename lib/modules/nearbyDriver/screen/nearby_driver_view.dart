import 'package:cabswalle/modules/nearbyDriver/data/models/nearby_driver_model.dart';
import 'package:cabswalle/widgets/nearby_driver_card.dart';
import 'package:flutter/material.dart';

class NearbyDriverScreen extends StatelessWidget {
  const NearbyDriverScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Nearby Drivers",
          style: TextStyle(fontSize: 20),
        ),
        centerTitle: true,
      ),
      body: SafeArea(
        child: dummyDrivers.isEmpty
            ? const Center(
                child: Text(
                  "No nearby drivers available",
                  style: TextStyle(fontSize: 16),
                ),
              )
            : Padding(
                padding: const EdgeInsets.all(16.0),
                child: ListView.builder(
                  itemCount: dummyDrivers.length,
                  itemBuilder: (context, index) {
                    var driver = dummyDrivers[index];
                    return Padding(
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      child: NearbyDriversCard(
                        verifiedDriver: driver,
                      ),
                    );
                  },
                ),
              ),
      ),
    );
  }
}
