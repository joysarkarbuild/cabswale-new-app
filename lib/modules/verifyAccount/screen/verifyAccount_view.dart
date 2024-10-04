import 'package:cabswalle/core/app_colors.dart';
import 'package:cabswalle/widgets/submit_button.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class VerifyAccountScreen extends StatefulWidget {
  const VerifyAccountScreen({super.key});

  @override
  State<VerifyAccountScreen> createState() => _VerifyAccountScreenState();
}

class _VerifyAccountScreenState extends State<VerifyAccountScreen> {
  bool isLoading = false;

  // Dummy data to replace the backend data
  Map<String, dynamic> snapshot = {
    "name": "John Doe",
    "aadharCard": {"number": "1234-5678-9012"},
    "vehicles": [
      {"model": "Toyota Camry", "year": "2020"}
    ],
    "routes": [
      {"route": "Route 66"}
    ],
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Edit Profile",
          style: TextStyle(
            fontSize: 20,
            color: AppColors.myprimaryColor,
          ),
        ),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: VerificationOption(
              isVerified: snapshot["name"] != null &&
                  snapshot["name"].toString().isNotEmpty,
              onTap: () {},
              title: "Name, City & Profile Picture",
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: VerificationOption(
              isVerified: snapshot["aadharCard"] != null &&
                  snapshot["aadharCard"].isNotEmpty,
              onTap: () {},
              title: "Aadhar & Licence",
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: VerificationOption(
              isVerified: snapshot["vehicles"] != null &&
                  snapshot["vehicles"].isNotEmpty,
              onTap: () {},
              title: "Vehicles",
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: VerificationOption(
              isVerified:
                  snapshot["routes"] != null && snapshot["routes"].isNotEmpty,
              onTap: () {},
              title: "Top Routes",
            ),
          ),
          const Spacer(),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: SubmitButton(
              onTap: () async {
                setState(() {
                  isLoading = true;
                });

                // Check if all required fields are filled
                if (snapshot["name"] == null ||
                    snapshot["aadharCard"] == null ||
                    snapshot["vehicles"] == null ||
                    snapshot["routes"] == null) {
                  Fluttertoast.showToast(
                      msg: "Please complete all steps",
                      toastLength: Toast.LENGTH_SHORT,
                      gravity: ToastGravity.CENTER,
                      timeInSecForIosWeb: 1,
                      textColor: Colors.black,
                      backgroundColor: Colors.white,
                      fontSize: 16.0);
                  setState(() {
                    isLoading = false;
                  });
                  return;
                }

                // Simulate submission for verification
                await Future.delayed(const Duration(seconds: 2));

                Fluttertoast.showToast(
                    msg: "Submitted for verification.",
                    toastLength: Toast.LENGTH_SHORT,
                    gravity: ToastGravity.CENTER,
                    timeInSecForIosWeb: 1,
                    textColor: Colors.black,
                    backgroundColor: Colors.white,
                    fontSize: 16.0);

                setState(() {
                  isLoading = false;
                });
              },
              lable: "Submit for Verification",
              borderRadius: 6,
            ),
          ),
          const SizedBox(
            height: 30,
          ),
        ],
      ),
    );
  }
}

class VerificationOption extends StatelessWidget {
  final String title;
  final Function onTap;
  final bool isVerified;

  const VerificationOption(
      {super.key,
      required this.isVerified,
      required this.onTap,
      required this.title});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 0),
      child: InkWell(
        onTap: () {
          onTap();
        },
        child: Container(
          height: 50,
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(
              border: Border.all(
                color: AppColors.myprimaryColor,
              ),
              borderRadius: BorderRadius.circular(6)),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 10),
                child: Text(
                  title,
                  style: const TextStyle(
                      color: Colors.black,
                      fontSize: 16,
                      fontWeight: FontWeight.w500),
                ),
              ),
              const Spacer(),
              Padding(
                padding: const EdgeInsets.only(right: 10),
                child: Icon(
                  isVerified ? Icons.check_box : Icons.arrow_forward,
                  color: isVerified ? Colors.green : Colors.black,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
