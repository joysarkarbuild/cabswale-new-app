import 'package:cabswalle/widgets/centre_loading.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class EmergencyNumbers extends StatefulWidget {
  const EmergencyNumbers({super.key});

  @override
  State<EmergencyNumbers> createState() => _EmergencyNumbersState();
}

class _EmergencyNumbersState extends State<EmergencyNumbers> {
  List allNumbers = [];
  bool isLoading = true;

  void getData() {
    FirebaseFirestore.instance
        .collection("community")
        .doc("emergency")
        .get()
        .then((value) {
      setState(() {
        isLoading = false;
        allNumbers = value.data()!["list"];
      });
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
                        padding: EdgeInsets.only(
                            left: 20, right: 20, top: 20, bottom: 10),
                        margin: EdgeInsets.only(bottom: 10),
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
                                  icon: Icon(Icons.call, color: Colors.white),
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
