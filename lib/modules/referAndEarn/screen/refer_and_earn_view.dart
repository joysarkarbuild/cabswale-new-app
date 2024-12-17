import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class ReferAndEarnScreen extends StatelessWidget {
  const ReferAndEarnScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Refer & Earn"),
        centerTitle: true,
      ),
      body: SizedBox(
        width: MediaQuery.of(context).size.width,
        child: Column(
          children: [
            const SizedBox(
              height: 10,
            ),
            const SizedBox(
              height: 10,
            ),
            const SizedBox(
              height: 20,
            ),
            const Text(
              "YOUR CODE",
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.w900),
            ),
            Container(
              margin: const EdgeInsets.only(top: 10),
              decoration: BoxDecoration(
                  border: Border.all(color: Colors.blue, width: 2),
                  borderRadius: BorderRadius.circular(4),
                  color: Colors.blue.withValues(alpha: 0.3)),
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 4),
              child: const SelectableText(
                "124567",
                style: TextStyle(
                    fontSize: 45,
                    letterSpacing: 6,
                    fontWeight: FontWeight.bold),
              ),
            ),
            const SizedBox(
              height: 30,
            ),
            ElevatedButton(
              onPressed: () async {
                String code = "124567";
                String message = '''Bhaisaheb,
मैं कैब्सवाले ऐप से बहुत खुश हूं। कैब्सवाले ऐप हर भाई के लिए बहुत जरूरी है। आप भी आज ही डाउनलोड करो।
https://play.google.com/store/apps/details?id=com.app.cabswalle
डाउनलोड करने के बाद ये कोड इस्तेमाल करो और 3 दिन की Membership और 100 कैब Coins पाओ।
Code: $code''';

                String whatsappUrl =
                    "whatsapp://send?text=${Uri.encodeComponent(message)}";

                // Check if the device can launch WhatsApp
                if (await canLaunchUrl(Uri.parse(whatsappUrl))) {
                  await launchUrl(Uri.parse(whatsappUrl));
                } else {
                  // If WhatsApp is not installed or cannot launch
                }
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(2),
                ),
                minimumSize: Size(MediaQuery.of(context).size.width * 0.72,
                    48), // Adjust the size as per your requirement
                padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 6), // Adjust the padding as per your requirement
              ),
              child: const Padding(
                padding: EdgeInsets.only(left: 10),
                child: Text(
                  'Share',
                  style: TextStyle(color: Colors.white, fontSize: 20),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
