import 'package:cabswalle/core/app_colors.dart';
import 'package:cabswalle/core/app_text_styles.dart';
import 'package:cabswalle/modules/membership/plans_screen.dart';
import 'package:cabswalle/services/button_clicker_service.dart';
import 'package:cabswalle/widgets/submit_button.dart';
import 'package:flutter/material.dart';

class MembershipWidget extends StatelessWidget {
  final bool isMembershipActive;
  final DateTime? endDate;
  final bool isHome;

  const MembershipWidget({
    super.key,
    required this.isMembershipActive,
    this.endDate,
    required this.isHome,
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

  String formatDateWithOrdinal(DateTime date) {
    // Get the day of the month
    int day = date.day;

    // Determine the ordinal suffix
    String suffix;
    if (day >= 11 && day <= 13) {
      suffix = 'th';
    } else {
      switch (day % 10) {
        case 1:
          suffix = 'st';
          break;
        case 2:
          suffix = 'nd';
          break;
        case 3:
          suffix = 'rd';
          break;
        default:
          suffix = 'th';
      }
    }

    // Format the month
    String month = _monthName(date.month);

    // Combine the formatted parts
    return '$day$suffix $month';
  }

// Helper function to get the month name
  String _monthName(int month) {
    const List<String> months = [
      'January',
      'February',
      'March',
      'April',
      'May',
      'June',
      'July',
      'August',
      'September',
      'October',
      'November',
      'December'
    ];
    return months[month - 1];
  }

  @override
  Widget build(BuildContext context) {
    if (endDate != null) {
      final now = DateTime.now();
      final daysRemaining = endDate!.difference(now).inDays + 1;

      if (daysRemaining > 7 && isHome) {
        return const SizedBox();
      }

      if (daysRemaining > 7 && !isHome) {
        return Padding(
          padding: const EdgeInsets.only(top: 10),
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 2),
            decoration: BoxDecoration(
                border: Border.all(color: AppColors.myprimaryColor),
                borderRadius: BorderRadius.circular(6)),
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
                      "Membership will end on ${formatDateWithOrdinal(endDate!)}",
                      style: AppTextStyles.style16w500(
                          color: AppColors.myprimaryColor),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      }
    }

    return Padding(
      padding: const EdgeInsets.only(top: 10),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 2),
        decoration: BoxDecoration(
            border: Border.all(color: AppColors.myprimaryColor),
            borderRadius: BorderRadius.circular(6)),
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
                      ButtonClickTracker.incrementRechargeNow();
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => PlansScreen(),
                          ));
                    },
                    lable: "Recharge Now",
                    height: 28,
                    width: 130,
                    labelsize: 13,
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
