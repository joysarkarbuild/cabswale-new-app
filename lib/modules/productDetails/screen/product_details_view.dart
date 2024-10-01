import 'package:cabswalle/widgets/common_image_view.dart';
import 'package:cabswalle/widgets/submit_button.dart';
import 'package:flutter/material.dart';

class ProductDetailsScreen extends StatelessWidget {
  const ProductDetailsScreen({super.key});

  // Dummy data to replace constructor values
  final String dummyTitle = "Dummy Product Title";
  final String dummyDesc =
      "This is a dummy product description for showcasing the product details.";
  final String dummyImageUrl = "https://via.placeholder.com/400";
  final String dummyVideoId = "dummyVideoId123";
  final double dummyDiscountedPrice = 99.99;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(dummyTitle),
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
                        onTap: () {},
                        child: CommonImageView(
                          url: dummyImageUrl,
                        ),
                      ),
                      const SizedBox(
                        height: 12,
                      ),
                      Text(
                        dummyDesc,
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
                onTap: () {
                  // Navigate to the thank you screen directly
                },
                lable: "Get best price",
                labelsize: 22,
                borderRadius: 5,
              ),
            )
          ],
        ),
      ),
    );
  }
}
