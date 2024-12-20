import 'package:cabswalle/services/banner_service.dart';
import 'package:cabswalle/widgets/common_image_view.dart';
import 'package:cabswalle/widgets/youtube_video_player.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class BannerImage extends StatelessWidget {
  final String bannerId;
  final Function? onTap;

  const BannerImage({super.key, required this.bannerId, this.onTap});

  @override
  Widget build(BuildContext context) {
    Map<String, dynamic> value = BannerService.bannersData ?? {};
    return Padding(
      padding: const EdgeInsets.only(left: 10, right: 10, bottom: 6, top: 6),
      child: InkWell(
        onTap: onTap != null
            ? () {
                onTap!();
              }
            : () {
                if (bannerId == "call2") {
                  launchUrl(Uri.parse("tel:+91940389036"));
                } else {
                  if (value[bannerId]["videoId"] != null &&
                      value[bannerId]["videoId"].toString().isNotEmpty) {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => YouTubePlayerCard(
                          videoId: value[bannerId]["videoId"],
                        ),
                      ),
                    );
                  }
                }
              },
        child: (value[bannerId]["active"])
            ? Column(
                children: [
                  _buildImageContent(value[bannerId]["url"]),
                  if (value[bannerId]["text"] != null)
                    Padding(
                      padding: const EdgeInsets.only(top: 8),
                      child: Text(
                        "${value[bannerId]["text"]}",
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                            fontSize: 16, fontWeight: FontWeight.w500),
                      ),
                    ),
                ],
              )
            : const SizedBox(),
      ),
    );
  }

  Widget _buildImageContent(dynamic url) {
    if (url is List && url.isNotEmpty) {
      return CarouselSlider(
        items: url.map<Widget>((imageUrl) {
          if (imageUrl is String && imageUrl.isNotEmpty) {
            return ClipRRect(
              borderRadius: BorderRadius.circular(4),
              child: CommonImageView(
                url: imageUrl,
                fit: BoxFit.contain,
              ),
            );
          } else {
            return const SizedBox(); // Handle invalid URLs
          }
        }).toList(),
        options: CarouselOptions(
          // height: 200, // Adjust height as needed
          autoPlay: true,
          autoPlayInterval: const Duration(seconds: 3), // Set autoplay interval
          autoPlayAnimationDuration:
              const Duration(milliseconds: 800), // Animation speed
          autoPlayCurve: Curves.easeInOut, // Animation curve
          enableInfiniteScroll: true, // Loop carousel
          viewportFraction: 1.0, // Show one image at a time
        ),
      );
    } else if (url is String && url.isNotEmpty) {
      return ClipRRect(
          borderRadius: BorderRadius.circular(4),
          child: CommonImageView(url: url));
    } else {
      return const SizedBox(); // Fallback for invalid or empty URL
    }
  }
}
