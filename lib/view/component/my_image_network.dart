import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../style/style.dart';

class CustomImageNetwork extends StatelessWidget {
  final String? image;
  final double height;
  final double width;
  final double radius;
  final BoxFit boxFit;

  const CustomImageNetwork(
      {Key? key,
        required this.image,
        this.height = 120,
        this.width = 120,
        this.radius = 16,  this.boxFit=BoxFit.cover })
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      width: width,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(radius),
        child: CachedNetworkImage(
          fit: boxFit,
          imageUrl: image ?? "",
          progressIndicatorBuilder: (context, text, DownloadProgress value) {
            return Container(
              decoration: BoxDecoration(
                color: Style.mediumGreyColor,
                borderRadius: BorderRadius.circular(radius),
              ),
            );
          },
          errorWidget: (context, _, __) {
            return const Icon(Icons.error);
          },
        ),
      ),
    );
  }
}