import 'package:almahbub_managment/view/pages/add_screen/add_product_screen.dart';
import 'package:almahbub_managment/view/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import '../../../model/product_model.dart';
import '../style/style.dart';
import 'my_image_network.dart';

class MyProduct extends StatelessWidget {
  final ProductModel model;
  final int index;
  final VoidCallback onLike;

  const MyProduct(
      {Key? key,
      required this.model,
      required this.index,
      required this.onLike})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(14),
          color: Style.mediumGreyColor),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            children: [
              CustomImageNetwork(
                  radius: 14,
                  height: 155,
                  width: double.infinity,
                  image: model.image ?? ""),
              Positioned(
                right: 0,
                child: IconButton(
                    onPressed: onLike,
                    icon: Icon(
                      model.isLike ? Icons.favorite : Icons.favorite_border,
                      color: Style.redColor,
                    )),
              ),
              Positioned(
                left: 12,
                top: 10,
                child: model.discount != null && model.discount != 0
                    ? Container(
                        padding: const EdgeInsets.symmetric(
                            vertical: 3, horizontal: 7),
                        decoration: BoxDecoration(
                            color: kBrandColor,
                            borderRadius: BorderRadius.circular(5)),
                        child: Text("-${model.discount}%"))
                    : const SizedBox.shrink(),
              ),
              Positioned(
                bottom: 4,
                right: 4,
                child: IconButton(
                  splashRadius: 32,
                  onPressed: () {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (_) => AddProductScreen(product: model)));
                  },
                  icon: Container(
                      padding: const EdgeInsets.all(5),
                      decoration: const BoxDecoration(
                          color: kBrandColor, shape: BoxShape.circle),
                      child: const Icon(Icons.edit, size: 20)),
                ),
              ),
            ],
          ),
          7.verticalSpace,
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            child: Text(
              "${model.name?.substring(0, 1).toUpperCase()}"
              "${model.name?.substring(1).toLowerCase()}",
              style: Style.textStyleNormal(size: 14),
            ),
          ),
          2.verticalSpace,
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            child: Text(
              NumberFormat.currency(
                      locale: 'uz', symbol: "so'm", decimalDigits: 0)
                  .format(model.price),
              style: Style.textStyleNormal(
                  size: model.discount != null && model.discount != 0 ? 13 : 14,
                  isActive: model.discount != null && model.discount != 0),
            ),
          ),
          model.discount != null && model.discount != 0
              ? Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  child: Text(
                    NumberFormat.currency(
                            locale: 'uz', symbol: "so'm", decimalDigits: 0)
                        .format((model.price ?? 0) -
                            (((model.price ?? 0) / 100).toDouble() *
                                model.discount!.toDouble())),
                    style: Style.textStyleNormal(size: 13),
                  ),
                )
              : const SizedBox.shrink(),
          7.verticalSpace,
        ],
      ),
    );
  }
}
