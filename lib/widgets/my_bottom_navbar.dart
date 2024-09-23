import 'package:cabswalle/core/app_colors.dart';
import 'package:flutter/material.dart';

class MyBottomNavBar extends StatelessWidget {
  const MyBottomNavBar({
    super.key,
    this.height = 65,
    this.elevation = 0,
    this.color = Colors.white,
    this.labelStyle = const TextStyle(fontSize: 12),
    this.selectedLabelStyle = const TextStyle(fontSize: 13),
    this.navBarDecoration,
    this.showIndicator = true,
    required this.bottomNavBarItems,
    required this.currentIndex,
    this.onTap,
    this.indicatorColor,
    this.indicatorPadding,
  });

  final double height;
  final Color color;
  final Color? indicatorColor;
  final double? indicatorPadding;
  final double elevation;
  final List bottomNavBarItems;
  final int currentIndex;
  final void Function(int index)? onTap;
  final TextStyle labelStyle;
  final TextStyle selectedLabelStyle;
  final bool showIndicator;
  final BoxDecoration? navBarDecoration;

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return SafeArea(
      child: Container(
        height: height,
        width: size.width,
        padding: EdgeInsets.symmetric(horizontal: size.width * 0.03),
        decoration: navBarDecoration ??
            BoxDecoration(color: color, boxShadow: [
              BoxShadow(
                  color: Colors.grey,
                  blurRadius: elevation,
                  spreadRadius: elevation)
            ]),
        child: Row(
          children: bottomNavBarItems.map((item) {
            var itemIndex = bottomNavBarItems.indexOf(item);
            bool isSelected = currentIndex == itemIndex;
            return Expanded(
              child: GestureDetector(
                onTap: () {
                  onTap!(itemIndex);
                },
                child: Container(
                  color: Colors.transparent,
                  height: double.infinity,
                  width: double.infinity,
                  child: Column(
                    children: [
                      if (showIndicator)
                        Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: indicatorPadding ?? 0),
                          child: Container(
                              height: 2,
                              width: double.infinity,
                              color: isSelected
                                  ? indicatorColor ??
                                      Theme.of(context).primaryColor
                                  : Colors.transparent),
                        ),
                      const SizedBox(
                        height: 7,
                      ),
                      Expanded(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            if (isSelected)
                              item.activeIcon != null
                                  ? SizedBox(
                                      height: item.iconSize,
                                      width: item.iconSize,
                                      child: item.activeIcon!,
                                    )
                                  : const Text('null'),
                            if (!isSelected)
                              item.icon != null
                                  ? SizedBox(
                                      height: item.iconSize,
                                      width: item.iconSize,
                                      child: item.icon!,
                                    )
                                  : const Text('null'),
                            const SizedBox(
                              height: 5,
                            ),
                            // Conditionally show/hide label for each item
                            if (item.showLabel && item.label != null)
                              Text(
                                item.label!,
                                style: isSelected
                                    ? selectedLabelStyle.copyWith(
                                        color: AppColors.myprimaryColor,
                                      ) // Change active label color
                                    : labelStyle,
                              ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: item.label == null ? 10 : 5,
                      ),
                    ],
                  ),
                ),
              ),
            );
          }).toList(),
        ),
      ),
    );
  }
}

class BottomNavBarItem {
  final Widget? icon;
  final Widget? activeIcon;
  final String? label;
  final bool showLabel; // Option to show/hide the label for this item
  final double iconSize; // Icon size for this item

  BottomNavBarItem({
    this.icon,
    this.activeIcon,
    this.label,
    this.showLabel = true, // Default to true (show label)
    this.iconSize = 20.0,
    // Default icon size
  });
}
