import 'package:cabswalle/modules/loan/data/models/loan_data_nodel.dart';
import 'package:cabswalle/widgets/common_image_view.dart';
import 'package:cabswalle/widgets/submit_button.dart';
import 'package:flutter/material.dart';

class LoanDetailsScreen extends StatefulWidget {
  const LoanDetailsScreen({super.key, required this.loan});
  final LoanModel loan;

  @override
  State<LoanDetailsScreen> createState() => _LoanDetailsScreenState();
}

class _LoanDetailsScreenState extends State<LoanDetailsScreen> {
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.loan.title),
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
                          url: widget.loan.media[0].url,
                        ),
                      ),
                      const SizedBox(height: 12),
                      Text(
                        widget.loan.desc,
                        textAlign: TextAlign.justify,
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w400,
                        ),
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
                onTap: () {},
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
