import 'package:cabswalle/constants/assets.dart';
import 'package:cabswalle/models/partner_setails.dart';
import 'package:cabswalle/modules/earnMoney/checkin_successful.dart';
import 'package:cabswalle/modules/nearbyDriver/data/models/nearby_driver_model.dart';
import 'package:cabswalle/services/snackbar_service.dart';
import 'package:cabswalle/widgets/centre_loading.dart';
import 'package:cabswalle/widgets/common_image_view.dart';
import 'package:cabswalle/widgets/submit_button.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:url_launcher/url_launcher.dart';

class PartnerDetailsScreen extends StatefulWidget {
  const PartnerDetailsScreen({super.key, required this.partner});
  final Partner partner;

  @override
  State<PartnerDetailsScreen> createState() => _PartnerDetailsScreenState();
}

class _PartnerDetailsScreenState extends State<PartnerDetailsScreen> {
  Map qrData = {};
  bool _isLoading = false; // Add this variable to track loading state

  @override
  void initState() {
    qrData.addAll({
      "partnerId": widget.partner.partnerId,
      "driverId": FirebaseAuth.instance.currentUser!.uid,
      "branchId": widget.partner.id,
      "qrGenerationTime": DateTime.now().toIso8601String(),
      "maxScans": widget.partner.maxScans,
      "distance": calculateDistanceInMeters(
          widget.partner.addressCoordinates[0],
          widget.partner.addressCoordinates[1]),
    });
    super.initState();
  }

  Future<List<QueryDocumentSnapshot<Map<String, dynamic>>>>
      getRecentTransactions(String branchId, String driverId) async {
    DateTime now = DateTime.now();
    DateTime last24Hours = now.subtract(const Duration(hours: 24));

    try {
      Timestamp last24HoursTimestamp = Timestamp.fromDate(last24Hours);

      QuerySnapshot<Map<String, dynamic>> querySnapshot =
          await FirebaseFirestore.instance
              .collection('partnerTransactions')
              .where('branchId', isEqualTo: branchId)
              .where("driverId", isEqualTo: driverId)
              .where('createdAt', isGreaterThan: last24HoursTimestamp)
              .orderBy('createdAt', descending: true)
              .get();

      return querySnapshot.docs;
    } catch (e) {
      SnackbarUtils.showErrorSnackBar(message: e.toString());
      return [];
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.partner.partnerDetails.title),
        centerTitle: true,
      ),
      body: Stack(
        children: [
          // Main UI
          SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(14),
              child: Column(
                children: [
                  InkWell(
                    onTap: () {},
                    child: CommonImageView(
                        width: MediaQuery.of(context).size.width,
                        fit: BoxFit.cover,
                        url: widget.partner.partnerDetails.media[0].url),
                  ),
                  IntrinsicWidth(
                    child: InkWell(
                      onTap: () {
                        launchUrl(Uri.parse(
                            "https://www.google.com/maps/search/?api=1&query=${widget.partner.addressCoordinates[0]},${widget.partner.addressCoordinates[1]}"));
                      },
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 12, vertical: 2),
                        decoration: const BoxDecoration(
                          color: Colors.deepPurple,
                          borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(6),
                            bottomRight: Radius.circular(6),
                          ),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            SvgPicture.asset(
                              Assets.iconsGoogleMapIcon,
                              height: 20,
                            ),
                            const SizedBox(
                              width: 4,
                            ),
                            Text(
                              widget.partner.location,
                              style: const TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8),
                    child: Text(
                      "Checkin at Hotel/restaurant and get ${widget.partner.cashback} coins in wallet",
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                          fontSize: 23, fontWeight: FontWeight.w600),
                    ),
                  ),
                  const SizedBox(height: 10),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 4),
                    child: Text(
                      widget.partner.partnerDetails.desc,
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        fontSize: 18,
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  SubmitButton(
                    onTap: () async {
                      setState(() {
                        _isLoading = true; // Start loading
                      });

                      try {
                        if (qrData["distance"] > 200) {
                          showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return AlertDialog(
                                title: const Text(
                                  'You are not at this location',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.redAccent,
                                  ),
                                ),
                                content: const Text(
                                  'Please visit the location and then click on checkin.',
                                  style: TextStyle(fontSize: 16),
                                ),
                                actions: [
                                  TextButton(
                                    child: const Text(
                                      'Try Again',
                                      style: TextStyle(
                                          color: Colors.blue, fontSize: 16),
                                    ),
                                    onPressed: () {
                                      Navigator.of(context).pop();
                                    },
                                  ),
                                ],
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(15),
                                ),
                              );
                            },
                          );
                          return;
                        }

                        List scans = await getRecentTransactions(
                            widget.partner.id,
                            FirebaseAuth.instance.currentUser!.uid);
                        if (scans.length >= widget.partner.maxScans) {
                          showDialog(
                            // ignore: use_build_context_synchronously
                            context: context,
                            builder: (BuildContext context) {
                              return AlertDialog(
                                title: const Text(
                                  'Reached daily limit',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.redAccent,
                                  ),
                                ),
                                content: Text(
                                  'You can not check in same partner more than ${widget.partner.maxScans} times',
                                  style: const TextStyle(fontSize: 16),
                                ),
                                actions: [
                                  TextButton(
                                    child: const Text(
                                      'Try Again',
                                      style: TextStyle(
                                          color: Colors.blue, fontSize: 16),
                                    ),
                                    onPressed: () {
                                      Navigator.of(context).pop();
                                    },
                                  ),
                                ],
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(15),
                                ),
                              );
                            },
                          );
                          return;
                        }

                        if (scans.isNotEmpty) {
                          Timestamp lastScanTime = scans[0].data()["createdAt"];
                          DateTime lastScanDateTime = lastScanTime.toDate();
                          Duration differenceOfLastScan =
                              DateTime.now().difference(lastScanDateTime);

                          int differenceInMinutesOfLAstScan =
                              differenceOfLastScan.inMinutes;
                          if (differenceInMinutesOfLAstScan < 60) {
                            showDialog(
                              // ignore: use_build_context_synchronously
                              context: context,
                              builder: (BuildContext context) {
                                return AlertDialog(
                                  title: const Text(
                                    'Multiple Check In',
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.redAccent,
                                    ),
                                  ),
                                  content: const Text(
                                    'You can only check in once in an hour, please try again!',
                                    style: TextStyle(fontSize: 16),
                                  ),
                                  actions: [
                                    TextButton(
                                      child: const Text(
                                        'Try Again',
                                        style: TextStyle(
                                            color: Colors.blue, fontSize: 16),
                                      ),
                                      onPressed: () {
                                        Navigator.of(context).pop();
                                      },
                                    ),
                                  ],
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(15),
                                  ),
                                );
                              },
                            );
                            return;
                          }
                        }

                        await FirebaseFirestore.instance
                            .collection("partnerTransactions")
                            .add({
                          ...qrData,
                          "createdAt": DateTime.now(),
                        });

                        // ignore: use_build_context_synchronously
                        Navigator.pop(context);
                        Navigator.push(
                            // ignore: use_build_context_synchronously
                            context,
                            MaterialPageRoute(
                              builder: (context) => CheckinSuccessful(
                                cabCoins: widget.partner.cashback,
                              ),
                            ));
                      } finally {
                        setState(() {
                          _isLoading = false; // Stop loading
                        });
                      }
                    },
                    lable: "Check In",
                  ),
                  const SizedBox(height: 20),
                ],
              ),
            ),
          ),
          // Loading overlay
          if (_isLoading)
            Container(
              color: Colors.black
                  .withValues(alpha: 0.5), // Semi-transparent overlay
              child: CentreLoading(),
            ),
        ],
      ),
    );
  }
}
