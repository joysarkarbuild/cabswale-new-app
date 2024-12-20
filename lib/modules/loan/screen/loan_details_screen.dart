import 'package:cabswalle/modules/loan/data/models/loan_data_nodel.dart';
import 'package:cabswalle/widgets/common_image_view.dart';
import 'package:cabswalle/widgets/submit_button.dart';
import 'package:cabswalle/widgets/thank_you_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class LoanDetailsScreen extends StatefulWidget {
  const LoanDetailsScreen({super.key, required this.product});
  final LoanModel product;

  @override
  State<LoanDetailsScreen> createState() => _LoanDetailsScreenState();
}

class _LoanDetailsScreenState extends State<LoanDetailsScreen> {
  bool isLoading = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.product.title),
        centerTitle: true,
      ),
      body: SizedBox(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: Column(
          children: [
            SizedBox(
              height: MediaQuery.of(context).size.height - 200,
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(18),
                child: SizedBox(
                  width: MediaQuery.of(context).size.width,
                  child: Column(
                    children: [
                      InkWell(
                          onTap: () {
                            // Navigator.push(
                            //     context,
                            //     MaterialPageRoute(
                            //       builder: (context) => YouTubePlayerCard(
                            //           videoId:
                            //               widget.product.media[1].videoId!),
                            //     ));

                            launchUrl(Uri.parse("tel:+919403890306"));
                          },
                          child: CommonImageView(
                              url: widget.product.media[0].url)),
                      const SizedBox(
                        height: 12,
                      ),
                      Text(
                        widget.product.desc,
                        textAlign: TextAlign.justify,
                        style: const TextStyle(
                            fontSize: 18, fontWeight: FontWeight.w400),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            const Spacer(),
            Padding(
              padding: const EdgeInsets.all(18.0),
              child: SubmitButton(
                onTap: () async {
                  setState(() {
                    isLoading = true;
                  });

                  await FirebaseFirestore.instance
                      .collection("redeemWalletRequests")
                      .add({
                    "driverId": FirebaseAuth.instance.currentUser!.uid,
                    "status": "pending",
                    "type": "loan",
                    "createdAt": DateTime.now(),
                  });
                  Navigator.pushReplacement(
                      // ignore: use_build_context_synchronously
                      context,
                      MaterialPageRoute(
                        builder: (context) => const ThankYouScreen(),
                      ));
                },
                lable: "Apply Now",
                labelsize: 20,
                loading: isLoading,
                borderRadius: 5,
              ),
            )
          ],
        ),
      ),
    );
  }
}
