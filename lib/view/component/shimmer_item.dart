import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import '../Style/style.dart';

class ShimmerItem extends StatelessWidget {
  final double height;
  final double width;
  final double radius;

  const ShimmerItem({Key? key, required this.height, required this.width, required this.radius})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(radius),
      child: SizedBox(
        width: width,
        height: height,
        child: Shimmer.fromColors(
          baseColor: Style.shimmerBaseColor,
          highlightColor: Style.shimmerHighlightColor,
          child:
              Container(width: width, height: height, color: Style.shimmerColor),
        ),
      ),
    );
  }
}
