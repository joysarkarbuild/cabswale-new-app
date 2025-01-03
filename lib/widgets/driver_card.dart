import 'package:cabswalle/constants/assets.dart';
import 'package:cabswalle/core/app_colors.dart';
import 'package:cabswalle/modules/myprofile/screen/myprofile_view.dart';
import 'package:cabswalle/modules/nearbyDriver/data/models/nearby_driver_model.dart';
import 'package:cabswalle/services/driver_service.dart';
import 'package:cabswalle/services/login_manager.dart';
import 'package:cabswalle/services/snackbar_service.dart';
import 'package:cabswalle/widgets/common_image_view.dart';
import 'package:cabswalle/widgets/submit_button.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:url_launcher/url_launcher.dart';

class VerifiedDriversCard extends StatelessWidget {
  final NearbyDriverModel verifiedDriver;
  final String selectedOption;
  const VerifiedDriversCard({
    required this.verifiedDriver,
    required this.selectedOption,
    super.key,
  });

  void sendWhatsAppMessage(String phoneNumber, String message) async {
    String url = 'https://wa.me/$phoneNumber/?text=$message';
    // if (await canLaunch(url)) {
    await launchUrl(Uri.parse(url));
    debugPrint('sending message: $url');
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      margin: const EdgeInsets.symmetric(vertical: 5),
      decoration: BoxDecoration(
        border: Border.all(color: AppColors.myBlack45),
      ),
      child: Column(
        children: [
          InkWell(
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>
                        MyprofileScreen(userId: verifiedDriver.id),
                  ));
            },
            child: Row(
              children: [
                Row(
                  children: [
                    (verifiedDriver.displayPic == null ||
                            verifiedDriver.displayPic == "")
                        ? Container(
                            height: 44,
                            width: 44,
                            decoration: BoxDecoration(
                                image: const DecorationImage(
                                    image: AssetImage(
                                        "assets/images/default_user.jpg")),
                                borderRadius: BorderRadius.circular(22)))
                        : ClipRRect(
                            borderRadius: BorderRadius.circular(22),
                            child: CommonImageView(
                              height: 44,
                              width: 44,
                              url: verifiedDriver.displayPic,
                            ),
                          ),
                    const SizedBox(
                      width: 10,
                    ),
                    SizedBox(
                      width: MediaQuery.of(context).size.width - 98,
                      child: Stack(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      Container(
                                        constraints: BoxConstraints(
                                            maxWidth: MediaQuery.of(context)
                                                    .size
                                                    .width -
                                                172),
                                        child: Text(
                                          verifiedDriver.name.isEmpty
                                              ? selectedOption == "notVerified"
                                                  ? "Not Available"
                                                  : verifiedDriver.phoneNo
                                              : verifiedDriver.name,
                                          maxLines: 1,
                                          overflow: TextOverflow.ellipsis,
                                          style: const TextStyle(
                                              color: Colors.black,
                                              fontSize: 13,
                                              fontWeight: FontWeight.w500),
                                        ),
                                      ),
                                      Padding(
                                          padding:
                                              const EdgeInsets.only(left: 4),
                                          child: Image.asset(
                                            verifiedDriver.fraud
                                                ? "assets/images/fr.png"
                                                : verifiedDriver.verified
                                                    ? "assets/images/ve.png"
                                                    : "assets/images/nv.png",
                                            width: 70,
                                          )),
                                    ],
                                  ),
                                  Text(
                                    verifiedDriver.city == ""
                                        ? "India"
                                        : verifiedDriver.city,
                                    style: const TextStyle(
                                        color: Colors.black,
                                        fontSize: 12,
                                        fontWeight: FontWeight.w400),
                                  ),
                                  Text(
                                    verifiedDriver.locationUpdatedAt!,
                                    style: const TextStyle(
                                        color: Colors.black,
                                        fontSize: 12,
                                        fontWeight: FontWeight.w400),
                                  ),
                                ],
                              ),
                            ],
                          ),
                          Positioned(
                            right: 0,
                            top: 2,
                            child: Container(
                                height: 22,
                                width: 60,
                                margin: const EdgeInsets.only(top: 26),
                                decoration: BoxDecoration(
                                    color: AppColors.myBlue,
                                    borderRadius: BorderRadius.circular(3)),
                                child: const Center(
                                  child: Text(
                                    'View Profile',
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 8),
                                  ),
                                )),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          Row(
            children: [
              SubmitButton(
                borderRadius: 3,
                onTap: () async {
                  try {
                    await FirebaseFirestore.instance
                        .collection('whatsappMessage')
                        .add({
                      'createdAt': DateTime.now(),
                      'leadId': "",
                      'receiver': {
                        'userId': verifiedDriver.id,
                        'name': verifiedDriver.name,
                        'phoneNo': verifiedDriver.phoneNo,
                      },
                      'sender': {
                        'userId': DriverService.instance.driverModel!.id,
                        'name': DriverService.instance.driverModel!.name,
                        'phoneNo': DriverService.instance.driverModel!.phoneNo
                      },
                    });
                    sendWhatsAppMessage(
                      verifiedDriver.phoneNo,
                      "",
                    );
                  } catch (e) {
                    SnackbarUtils.showErrorSnackBar(message: e.toString());
                  }
                },
                height: 40,
                width: 100,
                lable: "",
                icon: SvgPicture.asset(
                  'assets/icons/whatsapp.svg',
                  height: 22,
                ),
              ),
              Expanded(
                child: SubmitButton(
                  borderRadius: 3,
                  onTap: () async {
                    try {
                      await FirebaseFirestore.instance.collection('calls').add({
                        'createdAt': DateTime.now(),
                        'leadId': "",
                        'receiver': {
                          'userId': verifiedDriver.id,
                          'name': verifiedDriver.name,
                          'phoneNo': verifiedDriver.phoneNo,
                        },
                        'sender': {
                          'userId': DriverService.instance.driverModel!.id,
                          'name': DriverService.instance.driverModel!.name,
                          'phoneNo': DriverService.instance.driverModel!.phoneNo
                        },
                      });
                      launchUrl(Uri.parse("tel:${verifiedDriver.phoneNo}"));
                    } catch (e) {
                      SnackbarUtils.showErrorSnackBar(message: e.toString());
                    }
                  },
                  height: 40,
                  lable: LoginManager.isLogin ? "Call" : "Login",
                  icon: Icon(
                    LoginManager.isLogin ? Icons.call : Icons.login,
                    color: Colors.green,
                  ),
                ),
              ),
              SubmitButton(
                borderRadius: 3,
                onTap: () {
                  if (verifiedDriver.currentLocation == null) {
                    Fluttertoast.showToast(msg: "Location not updated");
                  } else {
                    launchUrl(Uri.parse(
                        "https://www.google.com/maps/search/?api=1&query=${verifiedDriver.currentLocation![0]},${verifiedDriver.currentLocation![1]}"));
                  }
                },
                height: 40,
                width: 100,
                lable: "",
                icon: SvgPicture.asset(
                  Assets.iconsGoogleMapIcon,
                  height: 30,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
