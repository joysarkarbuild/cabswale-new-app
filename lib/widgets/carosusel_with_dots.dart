import 'package:cabswalle/widgets/common_image_view.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

class CarosuselWithDots extends StatefulWidget {
  const CarosuselWithDots({super.key, required this.images});
  final List<String> images;

  @override
  State<CarosuselWithDots> createState() => _CarosuselWithDotsState();
}

class _CarosuselWithDotsState extends State<CarosuselWithDots> {
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        if (widget.images.isNotEmpty)
          CarouselSlider(
            options: CarouselOptions(
              height: 200.0,
              viewportFraction: 1,
              enableInfiniteScroll: false, // Prevent looping
              onPageChanged: (index, reason) {
                setState(() {
                  _currentIndex = index;
                });
              },
            ),
            items: widget.images.map((url) {
              return Builder(
                builder: (BuildContext context) {
                  return ClipRRect(
                    borderRadius: BorderRadius.circular(4),
                    child: CommonImageView(
                      url: url,
                      width: MediaQuery.of(context).size.width,
                      fit: BoxFit.cover,
                    ),
                  );
                },
              );
            }).toList(),
          ),
        // Only show dots if there are more than one image
        if (widget.images.length > 1)
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: widget.images.asMap().entries.map((entry) {
              return Container(
                width: 8.0,
                height: 8.0,
                margin:
                    const EdgeInsets.symmetric(vertical: 10.0, horizontal: 4.0),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: _currentIndex == entry.key
                      ? Colors.blueAccent
                      : Colors.grey,
                ),
              );
            }).toList(),
          ),
      ],
    );
  }
}
