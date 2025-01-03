import 'package:cabswalle/constants/assets.dart';
import 'package:cabswalle/constants/text_data.dart';
import 'package:cabswalle/core/app_colors.dart';
import 'package:cabswalle/core/app_text_styles.dart';
import 'package:cabswalle/modules/deals/screen/deals_confirmation_screen.dart';
import 'package:cabswalle/modules/home/data/models/lead_data_model.dart';
import 'package:cabswalle/modules/membership/plans_screen.dart';
import 'package:cabswalle/modules/myprofile/screen/myprofile_view.dart';
import 'package:cabswalle/modules/reportScreen/data/models/fraud_model.dart';
import 'package:cabswalle/modules/reportScreen/report_screen.dart';
import 'package:cabswalle/routes/app_routes.dart';
import 'package:cabswalle/services/calculation_util.dart';
import 'package:cabswalle/services/driver_service.dart';
import 'package:cabswalle/services/logger_service.dart';
import 'package:cabswalle/services/login_manager.dart';
import 'package:cabswalle/services/snackbar_service.dart';
import 'package:cabswalle/widgets/show_image.dart';
import 'package:cabswalle/widgets/submit_button.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:flutter/material.dart';

import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:url_launcher/url_launcher.dart';

class LeadsCard extends StatelessWidget {
  const LeadsCard({super.key, required this.lead});

  final LeadModel lead;
  void sendWhatsAppMessage(String phoneNumber, String message) async {
    String url = 'https://wa.me/$phoneNumber/?text=$message';
    await launchUrl(Uri.parse(url));
    LoggerService.logInfo("WhatsApp message sent");
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.only(left: 15, right: 15, top: 15),
      decoration: BoxDecoration(
          border: Border.all(color: AppColors.myBlack45),
          borderRadius: BorderRadius.circular(5)),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Text(''),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              RichText(
                  text: TextSpan(
                      text:
                          "${AppLocalizations.of(context)!.postedAt} : ", // '${AppLocalizations.of(context)!.date} :',
                      style: AppTextStyles.style15w500(),
                      children: [
                    TextSpan(
                        text: CalculationUtil.getTimeAgo(
                            lead.createdAt ?? DateTime.now()), // lead.at,
                        style: TextStyle(
                            fontSize: 14, fontWeight: FontWeight.bold))
                  ])),
              if (lead.leadType != null && lead.leadType != '')
                Container(
                  alignment: Alignment.centerLeft,
                  height: 25,
                  width: 100,
                  child: ShowImage(
                    boxFit: BoxFit.contain,
                    imagelink:
                        TextData.leadTypeData[lead.leadType!.toLowerCase()]
                            ['iconfilled'],
                  ),
                ),
            ],
          ),
          const SizedBox(
            height: 6,
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              placeWidget(
                  context: context,
                  toOrFrom: AppLocalizations.of(context)!.pick,
                  carTye: lead.carType ?? '',
                  createdAt: lead.createdAt),
              Container(
                  margin: const EdgeInsets.symmetric(horizontal: 20),
                  height: 22,
                  width: 22,
                  child: SvgPicture.asset(
                    Assets.iconsSwap,
                    fit: BoxFit.contain,
                    colorFilter: ColorFilter.mode(
                        lead.active!
                            ? AppColors.myprimaryColor
                            : AppColors.myGrey,
                        BlendMode.srcIn),
                  )),
              placeWidget(
                  context: context,
                  toOrFrom: AppLocalizations.of(context)!.drop,
                  carTye: lead.carType ?? '',
                  createdAt: lead.createdAt),
            ],
          ),

          InkWell(
            splashColor: Colors.transparent,
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>
                        MyprofileScreen(userId: lead.createdBy!.id ?? ""),
                  ));
            },
            child: Row(
              children: [
                Container(
                  height: 44,
                  width: 44,
                  decoration: BoxDecoration(
                      image: lead.createdBy!.profileImage == null ||
                              lead.createdBy!.profileImage!.isEmpty
                          ? const DecorationImage(
                              image: AssetImage(Assets.imagesDefaultUser))
                          : DecorationImage(
                              image: NetworkImage(
                                "${lead.createdBy!.profileImage}",
                              ),
                              fit: BoxFit.cover),
                      borderRadius: BorderRadius.circular(22)),
                ),
                const SizedBox(
                  width: 10,
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width - 116,
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
                                        maxWidth:
                                            MediaQuery.of(context).size.width -
                                                191),
                                    child: Text(
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                      lead.createdBy!.name!.isEmpty
                                          ? "Cabswale partner"
                                          : "${lead.createdBy?.name!}",
                                      style: const TextStyle(
                                          color: Colors.black,
                                          fontSize: 13,
                                          fontWeight: FontWeight.w500),
                                    ),
                                  ),
                                  lead.createdBy!.fraud ?? false
                                      ? Padding(
                                          padding:
                                              const EdgeInsets.only(left: 4),
                                          child: Image.asset(
                                            Assets.imagesFr,
                                            width: 70,
                                          ))
                                      : Padding(
                                          padding:
                                              const EdgeInsets.only(left: 4),
                                          child: Image.asset(
                                            lead.createdBy!.verified ?? false
                                                ? Assets.imagesVe
                                                : Assets.imagesNv,
                                            width: 70,
                                          )),
                                ],
                              ),
                              const SizedBox(
                                height: 4,
                              ),
                              Text(
                                lead.createdBy!.city == null ||
                                        lead.createdBy!.city == ""
                                    ? "India"
                                    : lead.createdBy!.city!,
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
                        top: -8,
                        child: Container(
                            height: 20,
                            width: 60,
                            margin: const EdgeInsets.only(top: 26),
                            decoration: BoxDecoration(
                                color: AppColors.myBlue,
                                borderRadius: BorderRadius.circular(3)),
                            child: const Center(
                              child: Text(
                                'View Profile',
                                style:
                                    TextStyle(color: Colors.white, fontSize: 8),
                              ),
                            )),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),

          const Divider(
            thickness: 0.5,
            color: AppColors.myBlack,
          ),

          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 3),
                child: Text(
                  '${AppLocalizations.of(context)!.vehicle} : ',
                  style: AppTextStyles.style17w500(),
                ),
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width - 140,
                child: Text(lead.carType ?? "",
                    maxLines: 2,
                    style: const TextStyle(
                        fontSize: 17, fontWeight: FontWeight.bold)),
              ),
            ],
          ),
          Column(
            children: [
              const SizedBox(
                height: 10,
              ),
              ...[
                if (lead.createdBy != null &&
                    lead.createdBy!.name != null &&
                    lead.createdBy!.name!.isNotEmpty)
                  Row(
                    children: [
                      const SizedBox(
                        width: 60,
                      ),
                      if (lead.verified == true)
                        const Expanded(
                          child: Row(
                            children: [
                              Icon(
                                Icons.library_add_check_rounded,
                                color: AppColors.myGreen,
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              Text(
                                'Verified',
                                style: TextStyle(
                                    fontSize: 14, fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                        )
                    ],
                  ),
              ],
              if (lead.message != null && lead.message!.isNotEmpty) ...[
                Text(
                    '${AppLocalizations.of(context)!.message} : ${lead.message}'),
              ],
              const SizedBox(
                height: 14,
              ),
              SizedBox(
                width: double.infinity,
                child: Row(
                  children: [
                    Expanded(
                      child: SubmitButton(
                          borderRadius: 2,
                          labelColor: AppColors.myWhite,
                          color: AppColors.myprimaryColor,
                          onTap: () async {
                            if (LoginManager.isLogin) {
                              try {
                                if (DriverService
                                    .instance.driverModel!.membership!.active) {
                                  await FirebaseFirestore.instance
                                      .collection('whatsappMessage')
                                      .add({
                                    'createdAt': DateTime.now(),
                                    'leadId': lead.id,
                                    'receiver': {
                                      'userId': lead.createdBy?.id ?? '',
                                      'name': lead.createdBy?.name ?? '',
                                      'phoneNo': lead.createdBy?.phoneNo ?? ''
                                    },
                                    'sender': {
                                      'userId': DriverService
                                          .instance.driverModel!.id,
                                      'name': DriverService
                                          .instance.driverModel!.name,
                                      'phoneNo': DriverService
                                          .instance.driverModel!.phoneNo
                                    },
                                  });
                                  sendWhatsAppMessage(
                                    '${lead.createdBy!.phoneNo}',
                                    'Dear Sir \u{1F64F} \n\nMein aapki lead \u{1F697} mein interested hun, jo aapne cabswale app \u{1F4F1} par dali hai\n\nPickup: ${(lead.from!.city).toString()}\nDrop: ${(lead.to!.city).toString()}\nVehicle: ${lead.carType}\nMessage: ${lead.message}\n\nCabswale app download kariye\nhttps://play.google.com/store/apps/details?id=com.app.cabswalle',
                                  );
                                } else {
                                  SnackbarUtils.showSuccessSnackBar(
                                      message:
                                          "Please Activate Your Membership First!");
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => PlansScreen(),
                                      ));
                                }
                              } catch (e) {
                                SnackbarUtils.showErrorSnackBar(
                                    message: e.toString());
                              }
                            } else {
                              context.pushNamed(Names.login);
                            }
                          },
                          height: 36,
                          labelsize: 16,
                          lable: 'Whatsapp',
                          icon: SvgPicture.asset(
                            Assets.iconsWhatsapp,
                            height: 18,
                          )),
                    ),
                    const SizedBox(
                      width: 2,
                    ),
                    Expanded(
                      child: SubmitButton(
                        borderRadius: 2,
                        labelColor: AppColors.myWhite,
                        color: AppColors.myprimaryColor,
                        onTap: () async {
                          if (LoginManager.isLogin) {
                            try {
                              if (DriverService
                                  .instance.driverModel!.membership!.active) {
                                await FirebaseFirestore.instance
                                    .collection('calls')
                                    .add({
                                  'createdAt': DateTime.now(),
                                  'leadId': lead.id,
                                  'receiver': {
                                    'userId': lead.createdBy?.id ?? '',
                                    'name': lead.createdBy?.name ?? '',
                                    'phoneNo': lead.createdBy?.phoneNo ?? ''
                                  },
                                  'sender': {
                                    'userId':
                                        DriverService.instance.driverModel!.id,
                                    'name': DriverService
                                        .instance.driverModel!.name,
                                    'phoneNo': DriverService
                                        .instance.driverModel!.phoneNo
                                  },
                                });
                                launchUrl(Uri.parse(
                                    "tel:${lead.createdBy!.phoneNo}"));
                              } else {
                                SnackbarUtils.showSuccessSnackBar(
                                    message:
                                        "Please Activate Your Membership First!");
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => PlansScreen(),
                                    ));
                              }
                            } catch (e) {
                              SnackbarUtils.showErrorSnackBar(
                                  message: e.toString());
                            }
                          } else {
                            context.pushNamed(Names.login);
                          }
                        },
                        height: 36,
                        labelsize: 16,
                        lable: AppLocalizations.of(context)!.callNow,
                        icon: const Icon(
                          Icons.call_outlined,
                          size: 20,
                          color: Colors.green,
                        ),
                      ),
                    )
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 2, right: 2, bottom: 4),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.myRed,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(2),
                          ),
                          minimumSize: Size(
                              MediaQuery.of(context).size.width * 0.24,
                              20), // Adjust the size as per your requirement
                          padding: const EdgeInsets.symmetric(
                              horizontal: 10,
                              vertical:
                                  7.5), // Adjust the padding as per your requirement
                        ),
                        onPressed: () {
                          Navigator.of(context).push(
                            MaterialPageRoute<Null>(
                              builder: (BuildContext context) {
                                return ReportScreen(
                                  fraud: FraudModel(
                                      id: lead.createdBy!.id!,
                                      leadId: lead.id ?? "",
                                      name: lead.createdBy!.name ?? ""),
                                );
                              },
                              fullscreenDialog: true,
                            ),
                          );
                        },
                        child: const Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Padding(
                              padding: EdgeInsets.only(right: 2),
                              child: Icon(
                                Icons.report,
                                color: Colors.white,
                                size: 14,
                              ),
                            ),
                            Text(
                              'Report',
                              style:
                                  TextStyle(color: Colors.white, fontSize: 10),
                            ),
                          ],
                        )),
                    const SizedBox(
                      width: 6,
                    ),
                    Expanded(
                      child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppColors.myGreen,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(2),
                            ),
                            minimumSize: const Size(60,
                                20), // Adjust the size as per your requirement
                            padding: const EdgeInsets.symmetric(
                                horizontal: 12,
                                vertical:
                                    6), // Adjust the padding as per your requirement
                          ),
                          onPressed: () {
                            Navigator.of(context).push(
                              MaterialPageRoute<Null>(
                                builder: (BuildContext context) {
                                  return const DealsConfirmationScreen();
                                },
                                fullscreenDialog: true,
                              ),
                            );
                          },
                          child: const Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Padding(
                                padding: EdgeInsets.only(right: 2),
                                child: Icon(
                                  Icons.handshake,
                                  color: Colors.white,
                                  size: 14,
                                ),
                              ),
                              Text(
                                'Confirm Deal',
                                style: TextStyle(
                                    color: Colors.white, fontSize: 12),
                              ),
                            ],
                          )),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Expanded placeWidget({
    context,
    required String toOrFrom,
    bool active = true,
    String carTye = '',
    DateTime? createdAt,
  }) {
    bool isTo = toOrFrom == AppLocalizations.of(context)!.drop;

    return Expanded(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment:
            !isTo ? CrossAxisAlignment.start : CrossAxisAlignment.end,
        children: [
          Text(
            '$toOrFrom:',
            style: AppTextStyles.style16w500(),
          ),
          const SizedBox(
            height: 6,
          ),
          Text(
            isTo
                ? lead.to == null
                    ? 'null'
                    : lead.to!.city ?? 'null'
                : lead.from == null
                    ? 'null'
                    : lead.from!.city ?? 'null',
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
            textAlign: isTo ? TextAlign.end : TextAlign.start,
          ),
          const SizedBox(
            height: 10,
          ),
        ],
      ),
    );
  }
}
