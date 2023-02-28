import 'dart:io';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

import '../../../../application/product_controller.dart';
import '../../../utils/Style/style.dart';
import '../../../utils/component/my_form_field.dart';
import '../../../utils/constants.dart';

class CategoryDialog extends StatefulWidget {
  const CategoryDialog({Key? key}) : super(key: key);

  @override
  State<CategoryDialog> createState() => _CategoryDialogState();
}

class _CategoryDialogState extends State<CategoryDialog> {
  late TextEditingController _textEditingController;

  @override
  void initState() {
    _textEditingController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _textEditingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final state = context.watch<ProductController>();
    final event = context.read<ProductController>();
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
          color: kGreenColor, borderRadius: BorderRadius.circular(14)),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          state.categoryImagePath.isEmpty
              ? SizedBox(
                  height: 80,
                  width: 80,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(14),
                    child: Image.asset(
                      "assets/images/noimage.jpg",
                      fit: BoxFit.cover,
                    ),
                  ),
                )
              : SizedBox(
                  height: 80,
                  width: 80,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(14),
                    child: Image.file(
                      File(state.categoryImagePath),
                      fit: BoxFit.contain,
                    ),
                  ),
                ),
          18.verticalSpace,
          MyFormFiled(
              controller: _textEditingController, title: "add_category".tr()),
          18.verticalSpace,
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              GestureDetector(
                onTap: () {
                  event.getCategoryImageCamera();
                },
                child: Container(
                    height: 44.r,
                    width: 44.r,
                    padding: EdgeInsets.all(11.r),
                    decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: kWhiteColor.withOpacity(0.5)),
                    child: Icon(
                      Icons.camera_alt,
                      size: 22.r,
                      color: kGreenColor,
                    )),
              ),
              GestureDetector(
                onTap: () {
                  event.getCategoryImageGallery();
                },
                child: Container(
                    height: 44.r,
                    width: 44.r,
                    padding: EdgeInsets.all(11.r),
                    decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: kWhiteColor.withOpacity(0.5)),
                    child: Icon(
                      Icons.folder_copy,
                      size: 22.r,
                      color: kGreenColor,
                    )),
              ),
              GestureDetector(
                onTap: () {
                  event.clearCategoryImage();
                  Navigator.pop(context);
                },
                child: Container(
                  padding:
                      const EdgeInsets.symmetric(vertical: 8, horizontal: 18),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    color: kWhiteColor.withOpacity(0.5),
                  ),
                  child: Text(
                    "cancel".tr(),
                    style: Style.textStyleSemiBold(
                        textColor: kGreenColor, size: 14),
                  ),
                ),
              ),
              GestureDetector(
                onTap: () {
                  event.addCategory(
                      name: _textEditingController.text,
                      onSuccess: () {
                        event.clearCategoryImage();
                        Navigator.pop(context);
                      });
                },
                child: Container(
                  padding:
                      const EdgeInsets.symmetric(vertical: 8, horizontal: 18),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    color: kWhiteColor.withOpacity(0.5),
                  ),
                  child: state.isSaveCategoryLoading
                      ? const CircularProgressIndicator(
                          color: kGreenColor,
                          strokeWidth: 3,
                        )
                      : Text(
                          "ok".tr(),
                          style: Style.textStyleSemiBold(
                              textColor: kGreenColor, size: 14),
                        ),
                ),
              )
            ],
          ),
        ],
      ),
    );
  }
}
