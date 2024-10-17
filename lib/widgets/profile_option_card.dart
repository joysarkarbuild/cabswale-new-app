import 'package:cabswalle/core/app_text_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class ProfileOptionCard extends StatelessWidget {
  const ProfileOptionCard({
    super.key,
    required this.icon,
    required this.onTap,
    required this.title,
  });

  final String icon;
  final String title;
  final VoidCallback? onTap; // Changed to VoidCallback? (nullable)

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap, // InkWell accepts a VoidCallback?
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 22),
        child: Row(
          children: [
            SvgPicture.asset(
              icon,
              height: 24,
            ),
            const SizedBox(
              width: 20,
            ),
            Text(
              title,
              style: AppTextStyles.style17w500(),
            ),
            const Spacer(),
            const Icon(
              Icons.arrow_forward_ios_rounded,
              size: 20,
            )
          ],
        ),
      ),
    );
  }
}
