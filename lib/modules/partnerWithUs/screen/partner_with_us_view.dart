import 'package:cabswalle/widgets/submit_button.dart';
import 'package:flutter/material.dart';

class PartnerWithUsScreen extends StatelessWidget {
  const PartnerWithUsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Partner with us"),
        centerTitle: true,
      ),
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        padding: const EdgeInsets.all(10),
        child: Column(
          children: [
            const Spacer(),
            SubmitButton(
              onTap: () {},
              lable: "I am interested",
              borderRadius: 8,
            ),
            const SizedBox(
              height: 20,
            )
          ],
        ),
      ),
    );
  }
}
