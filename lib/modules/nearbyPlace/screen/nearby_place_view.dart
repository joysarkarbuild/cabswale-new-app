import 'package:cabswalle/modules/nearbyPlace/data/models/nearby_place_model.dart';
import 'package:cabswalle/widgets/nearby_place_card.dart';
import 'package:cabswalle/widgets/search_box.dart';
import 'package:flutter/material.dart';

class NearbyPlaceScreen extends StatelessWidget {
  const NearbyPlaceScreen({super.key, required this.typeOfPlace});
  final String typeOfPlace;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          typeOfPlace,
          style: const TextStyle(fontSize: 20),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(18),
        child: Column(
          children: [
            SearchBox(
              onChanged: () {},
            ),
            const SizedBox(
              height: 10,
            ),
            Column(
              children: dummyNearbyPlaces.map((place) {
                return NearbyPlaceCard(
                  type: "Petrol Pump",
                  place: place,
                );
              }).toList(),
            ),
          ],
        ),
      ),
    );
  }
}
