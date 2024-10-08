import 'package:cabswalle/constants/assets.dart';
import 'package:cabswalle/constants/text_data.dart';
import 'package:cabswalle/core/app_colors.dart';
import 'package:cabswalle/core/app_text_styles.dart';
import 'package:cabswalle/modules/home/data/models/lead_model.dart';
import 'package:cabswalle/widgets/show_image.dart';
import 'package:cabswalle/widgets/submit_button.dart';

import 'package:flutter/material.dart';

import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'package:flutter_svg/flutter_svg.dart';

class LeadsCard extends StatefulWidget {
  const LeadsCard({super.key, required this.lead});

  final LeadsModel lead;

  @override
  State<LeadsCard> createState() => _LeadsCardState();
}

class _LeadsCardState extends State<LeadsCard> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 5),
      padding: const EdgeInsets.only(left: 15, right: 15, top: 15),
      decoration: BoxDecoration(border: Border.all(color: AppColors.myBlack45)),
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
                      children: const [
                    TextSpan(
                        text: "Just Now", // lead.at,
                        style: TextStyle(
                            fontSize: 14, fontWeight: FontWeight.bold))
                  ])),
              if (widget.lead.leadType != '')
                Container(
                  alignment: Alignment.centerLeft,
                  height: 25,
                  width: 100,
                  child: ShowImage(
                    boxFit: BoxFit.contain,
                    imagelink: TextData
                            .leadTypeData[widget.lead.leadType!.toLowerCase()]
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
                  carTye: widget.lead.carType ?? '',
                  createdAt: widget.lead.createdAt),
              Container(
                  margin: const EdgeInsets.symmetric(horizontal: 20),
                  height: 22,
                  width: 22,
                  child: SvgPicture.asset(
                    Assets.iconsSwap,
                    fit: BoxFit.contain,
                    colorFilter: ColorFilter.mode(
                        widget.lead.active!
                            ? AppColors.myprimaryColor
                            : AppColors.myGrey,
                        BlendMode.srcIn),
                  )),
              placeWidget(
                  context: context,
                  toOrFrom: AppLocalizations.of(context)!.drop,
                  carTye: widget.lead.carType ?? '',
                  createdAt: widget.lead.createdAt),
            ],
          ),

          Row(
            children: [
              Container(
                height: 44,
                width: 44,
                decoration: BoxDecoration(
                    image: widget.lead.createdBy!.profileImage == null ||
                            widget.lead.createdBy!.profileImage!.isEmpty
                        ? const DecorationImage(
                            image: AssetImage(Assets.imagesDefaultUser))
                        : DecorationImage(
                            image: NetworkImage(
                              "${widget.lead.createdBy!.profileImage}",
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
                                    widget.lead.createdBy!.name!.isEmpty
                                        ? "Cabswale partner"
                                        : "${widget.lead.createdBy?.name!}",
                                    style: const TextStyle(
                                        color: Colors.black,
                                        fontSize: 13,
                                        fontWeight: FontWeight.w500),
                                  ),
                                ),
                                widget.lead.createdBy!.fraud ?? false
                                    ? Padding(
                                        padding: const EdgeInsets.only(left: 4),
                                        child: Image.asset(
                                          Assets.imagesFr,
                                          width: 70,
                                        ))
                                    : Padding(
                                        padding: const EdgeInsets.only(left: 4),
                                        child: Image.asset(
                                          widget.lead.createdBy!.verified ??
                                                  false
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
                              widget.lead.createdBy!.city == null ||
                                      widget.lead.createdBy!.city == ""
                                  ? "India"
                                  : widget.lead.createdBy!.city!,
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

          const Divider(
            thickness: 0.5,
            color: AppColors.myBlack,
          ),
          if (false)
            Container(
              height: 34,
              margin: const EdgeInsets.only(top: 6, bottom: 6),
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(border: Border.all(color: Colors.red)),
              child: const Center(
                child: Text(
                  "5 Drivers reported fraud",
                  style:
                      TextStyle(fontWeight: FontWeight.w500, color: Colors.red),
                ),
              ),
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
                child: Text(widget.lead.carType ?? "",
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
                if (widget.lead.createdBy != null &&
                    widget.lead.createdBy!.name != null &&
                    widget.lead.createdBy!.name!.isNotEmpty)
                  Row(
                    children: [
                      const SizedBox(
                        width: 60,
                      ),
                      if (widget.lead.verified == true)
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
              if (widget.lead.message != null &&
                  widget.lead.message!.isNotEmpty) ...[
                Text(
                    '${AppLocalizations.of(context)!.message} : ${widget.lead.message}'),
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
                          onTap: () async {},
                          height: 36,
                          labelsize: 16,
                          lable: 'Whatsapp',
                          icon: SvgPicture.asset(
                            Assets.iconsWhatsapp,
                            height: 18,
                          )

                          // Icon(
                          //   isBooked ? Icons.check_circle : Icons.call_outlined,
                          //   color: isBooked ? Colors.green : myWhite,
                          // ),
                          ),
                    ),
                    const SizedBox(
                      width: 2,
                    ),
                    Expanded(
                      child: SubmitButton(
                        borderRadius: 2,
                        labelColor: AppColors.myWhite,
                        color: AppColors.myprimaryColor,
                        onTap: () {},
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
                        onPressed: () {},
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
                          onPressed: () {},
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
                                'Confrim Deal',
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
                ? widget.lead.to == null
                    ? 'null'
                    : widget.lead.to!.city ?? 'null'
                : widget.lead.from == null
                    ? 'null'
                    : widget.lead.from!.city ?? 'null',
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
