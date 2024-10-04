import 'package:cabswalle/constants/assets.dart';
import 'package:cabswalle/core/app_colors.dart';
import 'package:cabswalle/modules/nearbyDriver/data/models/nearby_driver_model.dart';
import 'package:cabswalle/widgets/common_image_view.dart';
import 'package:cabswalle/widgets/submit_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:url_launcher/url_launcher.dart';

class NearbyDriversCard extends StatelessWidget {
  final NearbyDriverModel verifiedDriver;

  const NearbyDriversCard({
    required this.verifiedDriver,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Stack(
      clipBehavior: Clip.none,
      children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
          margin: const EdgeInsets.symmetric(vertical: 5),
          decoration: BoxDecoration(
            border: Border.all(color: AppColors.myBlack45),
          ),
          child: Column(
            children: [
              InkWell(
                onTap: () {},
                child: Row(
                  children: [
                    DriverProfileImage(verifiedDriver: verifiedDriver),
                    const SizedBox(width: 10),
                    DriverDetails(
                      verifiedDriver: verifiedDriver,
                      size: size,
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 10),
              DriverActions(
                verifiedDriver: verifiedDriver,
                onCallLead: () =>
                    launchUrl(Uri.parse("tel:${verifiedDriver.phoneNo}")),
                onWhatsappLead: () =>
                    sendWhatsAppMessage(verifiedDriver.phoneNo, ''),
              ),
            ],
          ),
        ),
        if (verifiedDriver.distance != null)
          DistanceIndicator(distance: verifiedDriver.distance!),
      ],
    );
  }

  void sendWhatsAppMessage(String phoneNumber, String message) async {
    String url = 'https://wa.me/$phoneNumber/?text=$message';
    await launchUrl(Uri.parse(url));
  }
}

class DistanceIndicator extends StatelessWidget {
  final double distance;

  const DistanceIndicator({
    required this.distance,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: -18,
      right: 3,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 2),
        decoration: const BoxDecoration(
          color: Colors.green,
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(6), topRight: Radius.circular(6)),
        ),
        child: Text(
          distance.toInt() >= 1000
              ? " ${distance ~/ 1000} km"
              : "${distance.toInt()} m",
          style:
              const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}

class DriverActions extends StatelessWidget {
  final NearbyDriverModel verifiedDriver;
  final VoidCallback onCallLead;
  final VoidCallback onWhatsappLead;

  const DriverActions({
    required this.verifiedDriver,
    required this.onCallLead,
    required this.onWhatsappLead,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        SubmitButton(
          borderRadius: 3,
          onTap: onWhatsappLead,
          height: 40,
          width: 100,
          lable: "",
          icon: SvgPicture.asset(
            Assets.iconsWhatsapp,
            height: 22,
          ),
        ),
        Expanded(
          child: SubmitButton(
            borderRadius: 3,
            onTap: onCallLead,
            height: 40,
            lable: "Call",
            icon: const Icon(
              Icons.call,
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
    );
  }
}

class DriverDetails extends StatelessWidget {
  final NearbyDriverModel verifiedDriver;
  final Size size;

  const DriverDetails({
    required this.verifiedDriver,
    required this.size,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width - 112,
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
                            maxWidth: MediaQuery.of(context).size.width - 172),
                        child: Text(
                          verifiedDriver.name.isEmpty
                              ? verifiedDriver.phoneNo
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
                        padding: const EdgeInsets.only(left: 4),
                        child: Image.asset(
                          verifiedDriver.fraud
                              ? Assets.imagesFr
                              : verifiedDriver.verified
                                  ? Assets.imagesVe
                                  : Assets.imagesNv,
                          width: 70,
                        ),
                      ),
                    ],
                  ),
                  Text(
                    verifiedDriver.city == "" ? "India" : verifiedDriver.city,
                    style: const TextStyle(
                        color: Colors.black,
                        fontSize: 12,
                        fontWeight: FontWeight.w400),
                  ),
                  Text(
                    verifiedDriver.locationUpdatedAt == null
                        ? "Location not updated"
                        : verifiedDriver.locationUpdatedAt!,
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
            child: Column(
              children: [
                const SizedBox(height: 10),
                Container(
                  height: 22,
                  width: 60,
                  margin: const EdgeInsets.only(top: 6),
                  decoration: BoxDecoration(
                      color: AppColors.myBlue,
                      borderRadius: BorderRadius.circular(3)),
                  child: const Center(
                    child: Text(
                      'View Profile',
                      style: TextStyle(color: Colors.white, fontSize: 8),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class DriverProfileImage extends StatelessWidget {
  final NearbyDriverModel verifiedDriver;

  const DriverProfileImage({
    required this.verifiedDriver,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 44,
      width: 44,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(22),
      ),
      child: ClipRRect(
          borderRadius: BorderRadius.circular(22),
          child: CommonImageView(
            imagePath: Assets.imagesDefaultUser,
          )),
    );
  }
}
