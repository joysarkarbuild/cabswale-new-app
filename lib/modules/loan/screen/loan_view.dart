import 'package:cabswalle/modules/loan/data/models/loan_data_nodel.dart';
import 'package:cabswalle/modules/loan/screen/loan_details_view.dart';
import 'package:cabswalle/widgets/common_image_view.dart';
import 'package:flutter/material.dart';

class LoanScreen extends StatelessWidget {
  const LoanScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Loan"),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.all(14),
              itemCount: loadData.length,
              itemBuilder: (context, index) {
                final imageUrl = loadData[index].coverPic;
                return InkWell(
                  onTap: () {
                    // Handle navigation to Loan Details or any other action
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => LoanDetailsScreen(
                          loan: loadData[index],
                        ),
                      ),
                    );
                  },
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 5),
                    child: CommonImageView(
                      width: MediaQuery.of(context).size.width,
                      fit: BoxFit.cover,
                      url: imageUrl,
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
