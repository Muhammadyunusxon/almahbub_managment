import 'package:almahbub_managment/presentation/utils/component/tap_holder.dart';
import 'package:flutter/material.dart';

import '../../../../infrastructure/model/banner_model.dart';
import '../../../utils/component/my_image_network.dart';
import '../../../utils/constants.dart';

class MyBanner extends StatelessWidget {
  final BannerModel model;
  final int index;
  final VoidCallback onLike;
  final VoidCallback onDelete;

  const MyBanner(
      {Key? key, required this.model, required this.index, required this.onLike, required this.onDelete})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery
        .of(context)
        .size;
    return Padding(
      padding: const EdgeInsets.only(right: 18),
      child: TapHolder(
        onDelete: onDelete,
        onEdit: onLike,
        child: GestureDetector(
          onTap: () {
            debugPrint(model.product.name);
          },
          child: Container(
        width: size.width - 65,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              color: kWhiteColor),
          child: CustomImageNetwork(
            radius: 12,
            image: model.image,
          ),
        ),
      ),
    ),);
  }
}
