import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

import '../../../controller/home_controller.dart';
import '../Style/style.dart';
import '../constants.dart';
import 'my_form_field.dart';

class FilterBottomBar extends StatefulWidget {
  const FilterBottomBar({
    Key? key,
  }) : super(key: key);

  @override
  State<FilterBottomBar> createState() => _FilterBottomBarState();
}

class _FilterBottomBarState extends State<FilterBottomBar> {
  late TextEditingController _searchController;
  late TextEditingController _fromController;
  late TextEditingController _toController;

  @override
  void initState() {
    _searchController = TextEditingController();
    _fromController = TextEditingController();
    _toController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _searchController.dispose();
    _fromController.dispose();
    _toController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final state = context.watch<HomeController>();
    final event = context.read<HomeController>();
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 25.w),
      decoration: const BoxDecoration(
          color: kWhiteColor,
          borderRadius: BorderRadius.vertical(top: Radius.circular(16))),
      child: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            18.h.verticalSpace,
            Row(
              children: [
                Text("Filter", style: Style.textStyleSemiBold(size: 18)),
                const Spacer(),
                IconButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    icon: Icon(Icons.remove))
              ],
            ),
            20.verticalSpace,
            Text("Narxi", style: Style.textStyleSemiBold(size: 15)),
            14.h.verticalSpace,
            Wrap(
              spacing: 7,
              runSpacing: 7,
              children: [
                for (int i = 0; i < state.listOfPrice.length; i++)
                  GestureDetector(
                    onTap: () {
                      event.changePriceIndex(i);
                    },
                    child: Container(
                      decoration: BoxDecoration(
                          color: state.selectPrice != -1
                              ? state.selectPrice ==i
                                  ? kBrandColor
                                  : kMediumColor
                              : kMediumColor,
                          borderRadius: BorderRadius.circular(10.r)),
                      padding:
                          EdgeInsets.symmetric(horizontal: 9.w, vertical: 7.h),
                      child: Text(
                        state.listOfPrice[i],
                        style: Style.textStyleNormal(size: 15.5),
                      ),
                    ),
                  )
              ],
            ),
            20.verticalSpace,
            Text("Kategoriya", style: Style.textStyleSemiBold(size: 15)),
            14.h.verticalSpace,
            Wrap(
              spacing: 7,
              runSpacing: 7,
              children: [
                for (int i = 0; i < state.listOfCategory.length; i++)
                  GestureDetector(
                    onTap: () {
                      event.changeCategoryIndex(state.listOfCategory[i]);
                    },
                    child: Container(
                      decoration: BoxDecoration(
                          color: state.listOfSelectCategory
                                  .contains(state.listOfCategory[i])
                              ? kBrandColor
                              : kMediumColor,
                          borderRadius: BorderRadius.circular(10.r)),
                      padding:
                          EdgeInsets.symmetric(horizontal: 9.w, vertical: 7.h),
                      child: Text(
                        state.listOfCategory[i].name ?? "",
                        style: Style.textStyleNormal(size: 15.5),
                      ),
                    ),
                  )
              ],
            ),
            18.h.verticalSpace,
            // PriceRange(fromController: _fromController, toController: _toController),
            24.h.verticalSpace,
          ],
        ),
      ),
    );
  }
}
