import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import '../constants.dart';
import '../Style/style.dart';
import 'filter_bottom_bar.dart';

class SearchFormField extends StatelessWidget {
  final TextEditingController controller;
  final ValueChanged<String?>? onchange;

  const SearchFormField({Key? key, required this.controller, this.onchange})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: TextFormField(
            controller: controller,
            onChanged: onchange,
            style: Style.textStyleNormal(textColor: kWhiteColor),
            decoration: InputDecoration(
                contentPadding:
                    const EdgeInsets.symmetric(vertical: 12, horizontal: 12),
                prefixIconConstraints: const BoxConstraints(maxHeight: 18),
                prefixIcon: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: SvgPicture.asset("assets/svg/search.svg", height: 16),
                ),
                hintText: "search_write".tr(),
                hintStyle: Style.textStyleNormal(
                    textColor: kWhiteColor.withOpacity(0.7), size: 15),
                filled: true,
                fillColor: kWhiteColor.withOpacity(0.2),
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide.none)),
          ),
        ),
        10.w.horizontalSpace,
        GestureDetector(
          onTap: () {
            showBottomSheet(
                backgroundColor: Colors.transparent,
                context: context,
                builder: (_) => const FilterBottomBar());
          },
          child: Container(
              padding: EdgeInsets.all(12.r),
              decoration: BoxDecoration(
                color: kWhiteColor.withOpacity(0.2),
                borderRadius: BorderRadius.circular(10.r),
              ),
              child: SvgPicture.asset(
                "assets/svg/Filter.svg",
                color: kWhiteColor,
                height: 22.r,
              )),
        ),
      ],
    );
  }
}
