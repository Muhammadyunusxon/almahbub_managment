import 'package:almahbub_managment/presentation/pages/home_screen/widget/my_banner.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

import '../../../../application/home_controller.dart';
import '../../../utils/component/my_product.dart';
import '../../../utils/constants.dart';
import '../../../utils/Style/style.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';

class Body extends StatelessWidget {
  const Body({super.key});

  @override
  Widget build(BuildContext context) {
    final state = context.watch<HomeController>();
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 18),
      child: Column(
        children: <Widget>[
          SizedBox(
            height: 200,
            child: AnimationLimiter(
              child: ListView.builder(
                  physics: const BouncingScrollPhysics(),
                  padding:
                      EdgeInsets.symmetric(horizontal: 26.w, vertical: 12.h),
                  scrollDirection: Axis.horizontal,
                  itemCount: state.listOfBanners.length,
                  itemBuilder: (context, index) {
                    return AnimationConfiguration.staggeredList(
                      position: index,
                      duration: const Duration(milliseconds: 375),
                      child: SlideAnimation(
                        verticalOffset: 50.0,
                        child: FadeInAnimation(
                          child: MyBanner(
                            model: state.listOfBanners[index],
                            index: index,
                            onLike: () {},
                            onDelete: () {},
                          ),
                        ),
                      ),
                    );
                  }),
            ),
          ),
          Row(
            children: [
              26.h.horizontalSpace,
              Text(
                'products'.tr(),
                style: Style.textStyleNormal(),
              ),
              const Spacer(),
              TextButton(
                onPressed: () {},
                child: Text(
                  'all'.tr(),
                  style: Style.textStyleNormal(
                      size: 14.5, textColor: kTextGreenColor),
                ),
              ),
              12.horizontalSpace,
            ],
          ),
          AnimationLimiter(
            child: GridView.builder(
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount: state.listOfProduct.length,
                padding: EdgeInsets.symmetric(horizontal: 20.w),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 18.w,
                    mainAxisExtent: 260.h,
                    mainAxisSpacing: 16.h),
                itemBuilder: (context, index) {
                  return AnimationConfiguration.staggeredGrid(
                    position: index,
                    columnCount: 2,
                    duration: const Duration(milliseconds: 375),
                    child: SlideAnimation(
                      verticalOffset: 50.0,
                      child: FadeInAnimation(
                        child: MyProduct(
                          model: state.listOfProduct[index],
                          index: index,
                          onLike: () {
                            context
                                .read<HomeController>()
                                .changeLike(index: index, isFav: false);
                          },
                          onDelete: () {
                            context.read<HomeController>().deleteProduct(
                                docId: state.listOfProduct[index].id ?? "",
                                image: state.listOfProduct[index].image ?? "");
                          },
                        ),
                      ),
                    ),
                  );
                }),
          ),
          18.h.verticalSpace
        ],
      ),
    );
  }
}
