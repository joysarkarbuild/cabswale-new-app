import 'package:cabswalle/services/driver_service.dart';
import 'package:cabswalle/services/snackbar_service.dart';
import 'package:cabswalle/widgets/banner_widget.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class ReferScreen extends StatefulWidget {
  const ReferScreen({super.key});

  @override
  State<ReferScreen> createState() => _ReferScreenState();
}

class _ReferScreenState extends State<ReferScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Refer & Earn"),
        centerTitle: true,
      ),
      body: SizedBox(
        width: MediaQuery.of(context).size.width,
        child: Column(
          children: [
            const SizedBox(
              height: 10,
            ),
            BannerImage(bannerId: "refer"),
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
              margin: EdgeInsets.only(top: 10),
              decoration: BoxDecoration(
                  border: Border.all(color: Colors.blue, width: 2),
                  borderRadius: BorderRadius.circular(4),
                  color: Colors.blue.withValues(alpha: 0.3)),
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 4),
              child: SelectableText(
                "${DriverService.instance.driverModel!.refer!.code}",
                style: const TextStyle(
                    fontSize: 45,
                    letterSpacing: 6,
                    fontWeight: FontWeight.bold),
              ),
            ),
            SizedBox(
              height: 30,
            ),
            ElevatedButton(
              onPressed: () async {
                String code =
                    DriverService.instance.driverModel!.refer!.code.toString();
                String message = '''Bhaisaheb,
मैं कैब्सवाले ऐप से बहुत खुश हूं। कैब्सवाले ऐप हर भाई के लिए बहुत जरूरी है। आप भी आज ही डाउनलोड करो।
https://play.google.com/store/apps/details?id=com.app.cabswalle
डाउनलोड करने के बाद ये कोड इस्तेमाल करो और 3 दिन की Membership और 100 कैब Coins पाओ।
Code: $code''';

                String whatsappUrl =
                    "whatsapp://send?text=${Uri.encodeComponent(message)}";
                Uri url = Uri.parse(whatsappUrl);

                // Check if the device can launch WhatsApp
                if (await canLaunchUrl(url)) {
                  await launchUrl(url);
                } else {
                  SnackbarUtils.showErrorSnackBar(
                      message: "Whatsapp is not installed");
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
