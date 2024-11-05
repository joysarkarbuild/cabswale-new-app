import 'package:cabswalle/core/app_colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CentreLoading extends StatelessWidget {
  const CentreLoading({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
          height: 60,
          width: 60,
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16),
              color: AppColors.myprimaryColor),
          child: (const CupertinoActivityIndicator(
            color: Colors.amber,
            radius: 16,
          ))), // Your loading indicator
    );
  }
}
