import 'package:cabswalle/modules/saveMoney/save_mone_thankyou_screen.dart';
import 'package:cabswalle/modules/wallet/data/models/product_model.dart';
import 'package:cabswalle/widgets/common_image_view.dart';
import 'package:cabswalle/widgets/submit_button.dart';
import 'package:cabswalle/widgets/youtube_video_player.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class SaveMoneyDetailsScreen extends StatefulWidget {
  const SaveMoneyDetailsScreen(
      {super.key, required this.product, required this.walletBalance});
  final ProductModel product;
  final int walletBalance;

  @override
  State<SaveMoneyDetailsScreen> createState() => _SaveMoneyDetailsScreenState();
}

class _SaveMoneyDetailsScreenState extends State<SaveMoneyDetailsScreen> {
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
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => YouTubePlayerCard(
                                      videoId:
                                          widget.product.media[1].videoId!),
                                ));
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
                    "productId": widget.product.id,
                    "payableAmount": widget.product.discountedPrice,
                    "walletAmount": widget.walletBalance,
                    "status": "pending",
                    "type": "product",
                    "createdAt": DateTime.now(),
                  });
                  Navigator.pushReplacement(
                      // ignore: use_build_context_synchronously
                      context,
                      MaterialPageRoute(
                        builder: (context) => const ThankYouScreenSaveMoney(),
                      ));
                },
                lable: "Get best price",
                labelsize: 22,
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
