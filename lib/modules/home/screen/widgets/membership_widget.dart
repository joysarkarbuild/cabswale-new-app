import 'package:cabswalle/core/app_colors.dart';
import 'package:cabswalle/core/app_text_styles.dart';
import 'package:cabswalle/widgets/submit_button.dart';
import 'package:flutter/material.dart';
import 'package:dotted_border/dotted_border.dart';

class MembershipWidget extends StatelessWidget {
  final bool isMembershipActive;
  final DateTime? endDate;

  const MembershipWidget({
    super.key,
    required this.isMembershipActive,
    this.endDate,
  });

  String getMembershipMessage() {
    if (!isMembershipActive) {
      return "Start Membership";
    }

    if (endDate != null) {
      final now = DateTime.now();
      final daysRemaining = endDate!.difference(now).inDays + 1;

      if (daysRemaining <= 0) {
        return "Membership ends today";
      } else if (daysRemaining == 1) {
        return "Membership will end tomorrow";
      } else {
        return "Membership will end in $daysRemaining days";
      }
    }

    return "Membership status unknown";
  }

  @override
  Widget build(BuildContext context) {
    if (endDate != null) {
      final now = DateTime.now();
      final daysRemaining = endDate!.difference(now).inDays + 1;

      if (daysRemaining > 7) {
        return const SizedBox();
      }
    }

    return Padding(
      padding: const EdgeInsets.only(top: 10),
      child: DottedBorder(
        color: AppColors.myprimaryColor,
        dashPattern: const [4],
        strokeWidth: 1.5,
        radius: const Radius.circular(5),
        borderType: BorderType.RRect,
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 3),
        child: ClipRRect(
          borderRadius: const BorderRadius.all(Radius.circular(12)),
          child: SizedBox(
            height: 40,
            width: MediaQuery.of(context).size.width,
            child: Row(
              mainAxisAlignment: !isMembershipActive
                  ? MainAxisAlignment.spaceBetween
                  : MainAxisAlignment.center,
              children: [
                Text(
                  getMembershipMessage(),
                  style: AppTextStyles.style16w500(
                      color: AppColors.myprimaryColor),
                ),
                if (!isMembershipActive)
                  SubmitButton(
                    onTap: () {
                      // Add your recharge logic here
                    },
                    lable: "Recharge Now",
                    height: 28,
                    width: 140,
                    labelsize: 15,
                    borderRadius: 4,
                  )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
