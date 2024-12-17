import 'package:cabswalle/constants/assets.dart';
import 'package:cabswalle/modules/wallet/data/models/product_model.dart';
import 'package:cabswalle/routes/app_routes.dart';
import 'package:cabswalle/widgets/common_image_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';

class WalletScreen extends StatelessWidget {
  const WalletScreen({super.key});

  // Dummy data for products and wallet balance
  static const int walletBalance = 1000;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Wallet"),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Container(
            height: 55,
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
              color: Colors.blue.withValues(alpha: 0.3),
              borderRadius: BorderRadius.circular(3),
              border: Border.all(color: Colors.blue),
            ),
            child: Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    "Wallet Balance : ",
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.w500),
                  ),
                  SvgPicture.asset(
                    Assets.iconsCabsCoin,
                    height: 25,
                  ),
                  const Text(
                    " $walletBalance",
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.w500),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 10),
          const Text(
            "Buy with your wallet balance",
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
          ),
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.all(14),
              itemCount: dummyProducts.length,
              itemBuilder: (context, index) {
                final e = dummyProducts[index];
                return InkWell(
                  onTap: () {
                    context.pushNamed(Names.productDetails);
                  },
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 5),
                    child: CommonImageView(
                      width: MediaQuery.of(context).size.width,
                      fit: BoxFit.cover,
                      url: e.coverPic,
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
