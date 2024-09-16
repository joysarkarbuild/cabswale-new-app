import 'package:fancy_shimmer_image/fancy_shimmer_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class ShowImage extends StatelessWidget {
  const ShowImage({
    super.key,
    this.imagelink = '',
    this.boxFit = BoxFit.cover,
  });
  final dynamic imagelink;
  final BoxFit boxFit;

  @override
  Widget build(BuildContext context) {
    // debugPrint('imageLink Runtype : ${imagelink.runtimeType}');
    if (imagelink == '' || imagelink == null) {
      return FancyShimmerImage(
        imageUrl: imagelink,
        boxFit: boxFit,
        errorWidget: myErrorImage,
      );
    } else if (imagelink.runtimeType != String) {
      return Image.file(
        imagelink,
        fit: boxFit,
      );
    } else if (imagelink.toString().contains('http') &&
        imagelink.toString().contains('://')) {
      return FancyShimmerImage(
        imageUrl: imagelink,
        boxFit: boxFit,
        errorWidget: myErrorImage,
      );
    } else if (imagelink.toString().contains('.svg') &&
        imagelink.toString().contains('assets')) {
      return SvgPicture.asset(
        imagelink,
        fit: boxFit,
        height: 26,
      );
    } else {
      return Image.asset(
        imagelink,
        fit: boxFit,
      );
    }
  }
}

Image myErrorImage = Image.network(
    'https://upload.wikimedia.org/wikipedia/commons/thumb/d/d1/Image_not_available.png/640px-Image_not_available.png');
