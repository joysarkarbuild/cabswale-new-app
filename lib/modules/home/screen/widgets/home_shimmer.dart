import 'package:cabswalle/core/screen_responsive.dart';
import 'package:cabswalle/widgets/lead_card_shimmer.dart';
import 'package:cabswalle/widgets/shimmer_container.dart';
import 'package:flutter/material.dart';

class HomeShimmer extends StatelessWidget {
  const HomeShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        child: Container(
          width: context.screenWidth,
          padding: EdgeInsets.only(left: 14, right: 14),
          child: Column(
            children: [
              SizedBox(
                height: 5,
              ),
              ShimmerContainer(height: 15, width: 120),
              SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  ShimmerContainer(
                      height: 45, width: context.screenWidth * 0.445),
                  ShimmerContainer(
                      height: 45, width: context.screenWidth * 0.445),
                ],
              ),
              SizedBox(
                height: 16,
              ),
              Row(
                children: [
                  ShimmerContainer(height: 15, width: 150),
                ],
              ),
              SizedBox(
                height: 14,
              ),
              ShimmerContainer(height: 50, width: context.screenWidth),
              SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  ShimmerContainer(
                      height: 45, width: context.screenWidth * 0.445),
                  ShimmerContainer(
                      height: 45, width: context.screenWidth * 0.445),
                ],
              ),
              SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  ShimmerContainer(
                      height: 75, width: context.screenWidth * 0.445),
                  ShimmerContainer(
                      height: 75, width: context.screenWidth * 0.445),
                ],
              ),
              SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  ShimmerContainer(
                      height: 25, width: context.screenWidth * 0.285),
                  ShimmerContainer(
                      height: 25, width: context.screenWidth * 0.285),
                  ShimmerContainer(
                      height: 25, width: context.screenWidth * 0.285),
                ],
              ),
              SizedBox(
                height: 10,
              ),
              LeadsCardShimmer(),
              LeadsCardShimmer(),
              LeadsCardShimmer(),
              LeadsCardShimmer(),
              LeadsCardShimmer(),
            ],
          ),
        ),
      ),
    );
  }
}
