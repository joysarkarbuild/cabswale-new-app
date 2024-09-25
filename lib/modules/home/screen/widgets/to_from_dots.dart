import 'package:cabswalle/core/app_colors.dart';
import 'package:flutter/material.dart';

Padding toFromDots({int postion = 1}) {
  return Padding(
    padding: const EdgeInsets.all(8.0),
    child: Row(
      children: [
        Container(
          height: 8,
          width: 8,
          decoration: BoxDecoration(
              color: postion == 1 ? AppColors.myprimaryColor : AppColors.myGrey,
              shape: BoxShape.circle),
        ),
        Container(
            height: 8,
            width: 7,
            alignment: Alignment.center,
            child: const Divider(
              color: AppColors.myBlack45,
              thickness: 1,
            )),
        Container(
          height: 8,
          width: 8,
          decoration: BoxDecoration(
              color: postion == 2 ? AppColors.myprimaryColor : AppColors.myGrey,
              shape: BoxShape.circle),
        ),
      ],
    ),
  );
}
