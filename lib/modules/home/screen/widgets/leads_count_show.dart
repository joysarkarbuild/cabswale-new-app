import 'package:cabswalle/constants/assets.dart';
import 'package:cabswalle/core/app_colors.dart';
import 'package:cabswalle/core/app_text_styles.dart';
import 'package:cabswalle/core/screen_responsive.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class ShowLeadCounts extends StatelessWidget {
  const ShowLeadCounts(
      {super.key, required this.todaysLeadCount, required this.weeksLeadCount});
  final int todaysLeadCount;
  final int weeksLeadCount;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Container(
          height: 70,
          padding: const EdgeInsets.all(8),
          width: context.screenWidth * 0.452,
          decoration: BoxDecoration(
              color: AppColors.myGreen,
              borderRadius: BorderRadius.circular(15)),
          child: Row(
            children: [
              Container(
                height: 45,
                width: 45,
                decoration: BoxDecoration(
                    color: AppColors.myWhite,
                    borderRadius: BorderRadius.circular(13)),
                child: Center(
                  child: SvgPicture.asset(Assets.iconsTodaysLeads),
                ),
              ),
              const SizedBox(
                width: 8,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(
                      top: 7,
                    ),
                    child: Text(
                      "Today's Leads",
                      style:
                          AppTextStyles.style14w700(color: AppColors.myWhite),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 6),
                    child: Text(
                      "$todaysLeadCount",
                      style: AppTextStyles.style19w800(color: Colors.white),
                    ),
                  )
                ],
              )
            ],
          ),
        ),
        Container(
          height: 70,
          padding: const EdgeInsets.all(8),
          width: context.screenWidth * 0.452,
          decoration: BoxDecoration(
              color: AppColors.myRed, borderRadius: BorderRadius.circular(15)),
          child: Row(
            children: [
              Container(
                height: 45,
                width: 45,
                decoration: BoxDecoration(
                    color: AppColors.myWhite,
                    borderRadius: BorderRadius.circular(13)),
                child: Center(
                  child: SvgPicture.asset(Assets.iconsWeeksLeads),
                ),
              ),
              const SizedBox(
                width: 8,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(
                      top: 7,
                    ),
                    child: Text(
                      "Week's Leads",
                      style:
                          AppTextStyles.style14w700(color: AppColors.myWhite),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 6),
                    child: Text(
                      "$weeksLeadCount",
                      style: AppTextStyles.style19w800(color: Colors.white),
                    ),
                  )
                ],
              )
            ],
          ),
        )
      ],
    );
  }
}
