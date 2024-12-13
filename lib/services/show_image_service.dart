import 'package:cabswalle/core/app_colors.dart';
import 'package:cabswalle/core/app_text_styles.dart';
import 'package:flutter/material.dart';

class ShowImageService extends StatelessWidget {
  final String imageUrl;

  // Constructor to receive the image URL
  const ShowImageService({super.key, required this.imageUrl});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.myBlack,
      appBar: AppBar(
        backgroundColor: AppColors.myBlack,
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(
              Icons.arrow_back,
              color: Colors.white,
            )),
      ),
      body: Center(
        child: imageUrl.isEmpty
            ? Text(
                "No Image Available",
                style: AppTextStyles.style17w600(color: Colors.white),
              )
            : InteractiveViewer(
                minScale: 0.5,
                maxScale: 4.0,
                boundaryMargin: const EdgeInsets.all(20.0),
                child: Image.network(imageUrl),
              ),
      ),
    );
  }
}
