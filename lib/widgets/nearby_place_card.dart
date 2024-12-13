import 'package:cabswalle/modules/nearbyPlace/data/models/nearby_place_model.dart';

import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class NearbyPlaceCard extends StatelessWidget {
  const NearbyPlaceCard({super.key, required this.place, required this.type});
  final NearbyPlace place;
  final String type;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            InkWell(
              onTap: () {
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      title: const Text(
                        'Report Incorrect Location',
                        style: TextStyle(fontWeight: FontWeight.w600),
                      ),
                      content: const Text(
                          'If you believe the location provided is incorrect, please report it to us. Your feedback helps us ensure accuracy and improve our services.'),
                      actions: <Widget>[
                        TextButton(
                          child: const Text(
                            'Cancel',
                            style: TextStyle(color: Colors.black),
                          ),
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                        ),
                        TextButton(
                          child: const Text(
                            'Report',
                            style: TextStyle(color: Colors.orange),
                          ),
                          onPressed: () {
                            Navigator.of(context).pop();
                            showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return AlertDialog(
                                  title: const Text(
                                    'Thank You',
                                    style:
                                        TextStyle(fontWeight: FontWeight.w600),
                                  ),
                                  content: const Text(
                                      'Thank you for reporting the incorrect location. Your feedback is valuable to us and helps improve our services.'),
                                  actions: <Widget>[
                                    TextButton(
                                      child: const Text(
                                        'OK',
                                        style: TextStyle(color: Colors.blue),
                                      ),
                                      onPressed: () {
                                        Navigator.of(context).pop();
                                      },
                                    ),
                                  ],
                                );
                              },
                            );
                          },
                        ),
                      ],
                    );
                  },
                );
              },
              child: const Icon(
                Icons.report_problem_rounded,
                color: Colors.red,
              ),
            ),
          ],
        ),
        Container(
          width: MediaQuery.of(context).size.width,
          padding:
              const EdgeInsets.only(left: 16, right: 16, top: 16, bottom: 8),
          margin: const EdgeInsets.only(bottom: 16),
          decoration: BoxDecoration(
              border: Border.all(color: Colors.blue),
              borderRadius: BorderRadius.circular(4)),
          child: Column(
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(width: 10),
                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          place.name,
                          style: const TextStyle(
                              fontSize: 17, fontWeight: FontWeight.w500),
                        ),
                        Text(
                          place.address,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                              fontSize: 11,
                              fontWeight: FontWeight.w400,
                              color: Colors.black87),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    width: 1,
                    height: 76,
                    margin: const EdgeInsets.symmetric(horizontal: 10),
                    decoration: const BoxDecoration(color: Colors.blue),
                  ),
                  Column(
                    children: [
                      const SizedBox(
                        height: 10,
                      ),
                      Text(
                        place.geoDistanceMeters > 999
                            ? "${place.geoDistanceMeters ~/ 1000} km"
                            : "${place.geoDistanceMeters.toInt()} M",
                        style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                            color: Colors.blue),
                      ),
                      const Text(
                        "Away",
                        style: TextStyle(fontWeight: FontWeight.w500),
                      )
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: ElevatedButton.icon(
                      onPressed: () async {
                        launchUrl(Uri.parse("tel:${place.phone}"));
                      },
                      icon: const Icon(Icons.call, color: Colors.white),
                      label: const Text(
                        "Call Now",
                        style: TextStyle(color: Colors.white),
                      ),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blue,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(4),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                      width: 8), // Add some spacing between the buttons
                  Expanded(
                    child: ElevatedButton.icon(
                      onPressed: () {
                        launchUrl(Uri.parse(
                            "https://www.google.com/maps/search/?api=1&query=${place.location[0]},${place.location[1]}"));
                      },
                      icon: const Icon(Icons.directions, color: Colors.white),
                      label: const Text(
                        "Direction",
                        style: TextStyle(color: Colors.white),
                      ),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blue,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(4),
                        ),
                      ),
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ],
    );
  }
}
