import 'package:cabswalle/core/app_colors.dart';
import 'package:cabswalle/widgets/shimmer_container.dart';
import 'package:flutter/material.dart';

class LeadsCardShimmer extends StatelessWidget {
  const LeadsCardShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
          border: Border.all(color: AppColors.myGrey),
          borderRadius: BorderRadius.circular(5)),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              placeWidget(),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 20),
                child: ShimmerContainer(
                  height: 20,
                  width: 20,
                ),
              ),
              placeWidget()
            ],
          ),
          const SizedBox(
            height: 14,
          ),
          const ShimmerContainer(height: 45, width: double.infinity)
        ],
      ),
    );
  }

  Expanded placeWidget() {
    return const Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ShimmerContainer(height: 18, width: 50),
          SizedBox(
            height: 10,
          ),
          ShimmerContainer(height: 23, width: 100),
          SizedBox(
            height: 10,
          ),
          ShimmerContainer(height: 17, width: 110),
        ],
      ),
    );
  }
}
