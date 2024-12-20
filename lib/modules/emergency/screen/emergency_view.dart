import 'package:cabswalle/widgets/centre_loading.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class EmergencyScreen extends StatefulWidget {
  const EmergencyScreen({super.key});

  @override
  State<EmergencyScreen> createState() => _EmergencyScreenState();
}

class _EmergencyScreenState extends State<EmergencyScreen> {
  List allNumbers = [];
  bool isLoading = true;

  // Replace backend data fetching with dummy data
  void getData() {
    setState(() {
      isLoading = false;
      allNumbers = [
        {"name": "Fire Department", "phone": "+1234567890"},
        {"name": "Police Station", "phone": "+0987654321"},
        {"name": "Ambulance Service", "phone": "+1122334455"},
        {"name": "Gas Emergency", "phone": "+1029384756"},
      ];
    });
  }

  @override
  void initState() {
    getData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Emergency Numbers",
          style: TextStyle(fontSize: 20),
        ),
        centerTitle: true,
      ),
      body: isLoading
          ? CentreLoading()
          : SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: Column(
                children: [
                  ...allNumbers.map((e) => Container(
                        width: MediaQuery.of(context).size.width,
                        padding: const EdgeInsets.only(
                            left: 20, right: 20, top: 20, bottom: 10),
                        margin: const EdgeInsets.only(bottom: 10),
                        decoration: BoxDecoration(
                            color: Colors.red.withValues(alpha: 0.4),
                            border: Border.all(color: Colors.blue),
                            borderRadius: BorderRadius.circular(4)),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              e["name"],
                              style: const TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.w600),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                ElevatedButton.icon(
                                  onPressed: () {
                                    launchUrl(Uri.parse("tel:${e["phone"]}"));
                                  },
                                  icon: const Icon(Icons.call,
                                      color: Colors.white),
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
                              ],
                            )
                          ],
                        ),
                      ))
                ],
              ),
            ),
    );
  }
}
