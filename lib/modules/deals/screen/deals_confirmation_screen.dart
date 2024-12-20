import 'package:cabswalle/models/dela_model.dart';
import 'package:cabswalle/modules/deals/screen/deal_confrim_screen.dart';
import 'package:cabswalle/services/snackbar_service.dart';
import 'package:cabswalle/widgets/banner_widget.dart';
import 'package:cabswalle/widgets/centre_loading.dart';
import 'package:cabswalle/widgets/submit_button.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:intl/intl.dart';
import 'package:url_launcher/url_launcher.dart';

class DealsConfirmationScreen extends StatefulWidget {
  const DealsConfirmationScreen({super.key});

  @override
  State<DealsConfirmationScreen> createState() =>
      _DealsConfirmationScreenState();
}

class _DealsConfirmationScreenState extends State<DealsConfirmationScreen> {
  final TextEditingController otpController = TextEditingController();
  final ScrollController _scrollController = ScrollController();

  List<DealModel> myDeals = [];
  DocumentSnapshot? lastDocument;
  bool isLoadingMore = false;
  bool hasMoreData = true;

  static const int dealsLimit = 10; // Number of deals to fetch per page

  @override
  void initState() {
    super.initState();
    getLeads();

    // Add scroll listener for pagination
    _scrollController.addListener(() {
      if (_scrollController.position.pixels ==
              _scrollController.position.maxScrollExtent &&
          !isLoadingMore &&
          hasMoreData) {
        getLeads(); // Fetch more leads when scrolled to bottom
      }
    });
  }

  Future<void> getLeads() async {
    if (isLoadingMore) return; // Prevent multiple simultaneous fetches
    setState(() {
      isLoadingMore = true;
    });

    try {
      Query query = FirebaseFirestore.instance
          .collection("deals")
          .where("acceptedBy.id",
              isEqualTo: FirebaseAuth.instance.currentUser!.uid)
          .limit(dealsLimit);

      if (lastDocument != null) {
        query = query.startAfterDocument(lastDocument!);
      }

      QuerySnapshot snapshot = await query.get();
      if (snapshot.docs.isNotEmpty) {
        lastDocument = snapshot.docs.last;
        List<DealModel> newDeals = snapshot.docs
            .map((e) => DealModel.fromJson(e.data() as Map<String, dynamic>?))
            .toList();

        setState(() {
          myDeals.addAll(newDeals);
          isLoadingMore = false;
        });

        if (newDeals.length < dealsLimit) {
          hasMoreData = false;
        }
      } else {
        setState(() {
          hasMoreData = false;
          isLoadingMore = false;
        });
      }
    } catch (e) {
      setState(() {
        isLoadingMore = false;
      });

      SnackbarUtils.showErrorSnackBar(
          message: "Error fetching deals. Please try again.");
    }
  }

  Future<void> verifyLead(String uid, String otp) async {
    final url = Uri.parse(
        'https://us-central1-bwi-cabswalle.cloudfunctions.net/lead-verify');
    final headers = {'Content-Type': 'application/json'};
    final body = jsonEncode({'uid': uid, 'otp': otp});

    // Show loading indicator
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return CentreLoading();
      },
    );

    try {
      final response = await http.post(url, headers: headers, body: body);

      // ignore: use_build_context_synchronously
      Navigator.pop(context); // Hide loading indicator

      if (response.statusCode == 200) {
        try {
          final responseData = jsonDecode(response.body);
          // Ensure proper format for printing

          if (responseData['status'] == true) {
            otpController.text = "";
            Navigator.push(
                // ignore: use_build_context_synchronously
                context,
                MaterialPageRoute(
                  builder: (context) => const DealConfromScreen(),
                ));
          } else {
            // Show error dialog with the message from the response
            showDialog(
              // ignore: use_build_context_synchronously
              context: context,
              builder: (BuildContext context) {
                return AlertDialog(
                  title: const Text(
                    'Error',
                    style: TextStyle(
                      color: Colors.red,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  content: Text(
                    responseData['msg'] ?? 'Unknown error occurred.',
                    style: const TextStyle(
                        fontSize: 16, fontWeight: FontWeight.w600),
                  ),
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
          }
        } catch (e) {
          SnackbarUtils.showErrorSnackBar(message: "Error parsing response.");
        }
      } else {
        SnackbarUtils.showErrorSnackBar(message: "Something went wrong!");
      }
    } catch (e) {
      // ignore: use_build_context_synchronously
      Navigator.pop(context); // Hide loading indicator in case of error

      SnackbarUtils.showErrorSnackBar(message: "Something went wrong!");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Deals",
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w600,
          ),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        controller: _scrollController, // Attach scroll controller
        child: Column(
          children: [
            BannerImage(
              bannerId: "deal",
            ),
            const Padding(
              padding: EdgeInsets.only(left: 16),
              child: Row(
                children: [
                  Text(
                    "Confirm Deal",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700),
                  )
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                children: [
                  Expanded(
                    child: SizedBox(
                      height: 44,
                      child: TextField(
                        controller: otpController,
                        keyboardType: TextInputType.number,
                        decoration: const InputDecoration(
                          labelText: 'Enter OTP',
                          border: OutlineInputBorder(),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 8,
                  ),
                  ElevatedButton(
                    onPressed: () {
                      // Validate OTP length
                      if (otpController.text.trim().length != 6) {
                        SnackbarUtils.showSuccessSnackBar(
                            message: "Enter a valid OTP!");
                      } else {
                        verifyLead(
                          FirebaseAuth.instance.currentUser!.uid,
                          otpController.text.trim(),
                        );
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue, // Background color
                      minimumSize: const Size(100, 44), // Width and height
                      shape: RoundedRectangleBorder(
                        borderRadius:
                            BorderRadius.circular(5), // Rounded corners
                      ),
                    ),
                    child: const Text(
                      "Confirm", // Corrected the typo from "Confrim"
                      style: TextStyle(
                        fontSize: 18,
                        color: Colors.white,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 4,
            ),
            const Padding(
              padding: EdgeInsets.only(left: 16, bottom: 10),
              child: Row(
                children: [
                  Text(
                    "My Deals",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700),
                  )
                ],
              ),
            ),
            if (myDeals.isEmpty) const Text("No Deals created yet!"),
            ...myDeals.map(
              (e) => Container(
                decoration: BoxDecoration(
                    border: Border.all(color: Colors.blue),
                    borderRadius: BorderRadius.circular(6)),
                padding: const EdgeInsets.all(16),
                margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        SizedBox(
                          width: MediaQuery.of(context).size.width * 0.33,
                          child: Text(
                            "${e.from["city"]}",
                            style: const TextStyle(
                                fontSize: 18, fontWeight: FontWeight.w600),
                          ),
                        ),
                        const Icon(
                          Icons.arrow_forward_rounded,
                          size: 29,
                          color: Colors.blue,
                        ),
                        SizedBox(
                          width: MediaQuery.of(context).size.width * 0.33,
                          child: Text(
                            "${e.to["city"]}",
                            style: const TextStyle(
                                fontSize: 20, fontWeight: FontWeight.w600),
                          ),
                        )
                      ],
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Row(
                      children: [
                        Text(
                            "Deal Closed On : ${DateFormat('d MMM, yyy h:mm a').format(e.createdAt.toDate())} "),
                      ],
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    if (e.dealDocument!.isNotEmpty)
                      SubmitButton(
                        onTap: () {
                          launchUrl(Uri.parse(e.dealDocument!));
                        },
                        lable: "Download Deal",
                        height: 30,
                        width: 180,
                        borderRadius: 3,
                      )
                  ],
                ),
              ),
            ),
            if (isLoadingMore) // Show loading indicator at the bottom
              const CentreLoading()
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    otpController.dispose();
    _scrollController.dispose(); // Dispose scroll controller
    super.dispose();
  }
}
