import 'package:cabswalle/constants/assets.dart';
import 'package:cabswalle/constants/text_data.dart';
import 'package:cabswalle/core/app_colors.dart';
import 'package:cabswalle/core/app_text_styles.dart';
import 'package:cabswalle/core/screen_responsive.dart';
import 'package:cabswalle/modules/home/data/models/lead_data_model.dart';
import 'package:cabswalle/services/calculation_util.dart';
import 'package:cabswalle/widgets/show_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_svg/flutter_svg.dart';

class MyLeadCard extends StatefulWidget {
  const MyLeadCard({super.key, required this.lead});
  final LeadModel lead;

  @override
  State<MyLeadCard> createState() => _MyLeadCardState();
}

class _MyLeadCardState extends State<MyLeadCard> {
  bool isActive = false;

  @override
  void initState() {
    super.initState();
    isActive = widget.lead.active ?? false;
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
                            widget.lead.createdAt ??
                                DateTime.now()), // lead.at,
                        style: TextStyle(
                            fontSize: 14, fontWeight: FontWeight.bold))
                  ])),
              if (widget.lead.leadType != null && widget.lead.leadType != '')
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
                        isActive ? AppColors.myprimaryColor : AppColors.myGrey,
                        BlendMode.srcIn),
                  )),
              placeWidget(
                  context: context,
                  toOrFrom: AppLocalizations.of(context)!.drop,
                  carTye: widget.lead.carType ?? '',
                  createdAt: widget.lead.createdAt),
            ],
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
            ],
          ),

          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 3),
                child: Text(
                  'OTP : ',
                  style: AppTextStyles.style17w500(),
                ),
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width - 140,
                child: Text("${widget.lead.otp}",
                    maxLines: 2,
                    style: const TextStyle(
                        fontSize: 17, fontWeight: FontWeight.bold)),
              ),
            ],
          ),

          SizedBox(
            height: 10,
          ),

          GestureDetector(
            onTap: () {
              setState(() {
                isActive = !isActive;
              });
              updateActive(isActive, widget.lead);
            },
            child: Container(
              height: 40,
              margin: const EdgeInsets.only(bottom: 10),
              width: context.screenWidth,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(4),
                border: Border.all(
                  color: isActive ? AppColors.myprimaryColor : Colors.green,
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    isActive
                        ? AppLocalizations.of(context)!.active
                        : AppLocalizations.of(context)!.booked,
                    style: TextStyle(
                        color:
                            isActive ? AppColors.myprimaryColor : Colors.green,
                        fontSize: 16),
                  ),
                  SizedBox(
                    width: 4,
                  ),
                  SizedBox(
                    height: 35,
                    width: 70,
                    child: FittedBox(
                      child: Switch.adaptive(
                        splashRadius: 3,
                        activeColor: AppColors.myprimaryColor,
                        inactiveTrackColor: Colors.green.withValues(alpha: 0.5),
                        inactiveThumbColor: Colors.green,
                        value: isActive,
                        onChanged: (value) {
                          setState(() {
                            isActive = !isActive;
                          });
                          updateActive(value, widget.lead);
                        },
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(
            height: 6,
          ),
        ],
      ),
    );
  }

  updateActive(bool val, LeadModel lead) async {
    await FirebaseFirestore.instance
        .collection('leads')
        .doc(lead.id)
        .update({'active': val});
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
