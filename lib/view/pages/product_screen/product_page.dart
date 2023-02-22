import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../../../controller/home_controller.dart';
import '../../../domen/model/product_model/product_model.dart';
import '../../utils/Style/style.dart';
import '../../utils/component/my_image_network.dart';
import '../../utils/constants.dart';
import '../../utils/size_config.dart';

class ProductPage extends StatefulWidget {
  final ProductModel? product;
  final String? docId;

  const ProductPage({Key? key, this.product, this.docId}) : super(key: key);

  @override
  State<ProductPage> createState() => _ProductPageState();
}

class _ProductPageState extends State<ProductPage> {
  @override
  void initState() {
    if (widget.product != null) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        context.read<HomeController>().changeSingleProduct(widget.product!);
      });
    } else {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        context.read<HomeController>().getSingleProduct(widget.docId ?? "");
      });
    }

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final state = context.watch<HomeController>();
    final event = context.read<HomeController>();
    SizeConfig().init(context);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: kGreenColor,
        title: const Text("Product"),
        actions: [
          IconButton(
            icon: SvgPicture.asset("assets/svg/share.svg",
                height: 20, color: kWhiteColor),
            onPressed: () {
              event.createDynamicLink(state.singleProduct!);
            },
          ),
          12.w.horizontalSpace
        ],
      ),
      body: state.isSingleProductLoading
          ? const Center(
              child: CircularProgressIndicator(
              color: kBrandColor,
            ))
          : ListView(
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 50.w),
                  child: Stack(
                    children: [
                      CustomImageNetwork(
                        height: (SizeConfig.screenWidth ?? 100),
                        image: state.singleProduct?.image ?? "",
                        radius: 0,
                        width: double.infinity
                        ,
                      ),
                      Positioned(
                          right: 20,
                          bottom: 20,
                          child: IconButton(
                            icon: SvgPicture.asset(
                                "assets/svg/${(state.singleProduct?.isLike ?? false) ? "favourite" : "favourite_outline"}.svg"),
                            onPressed: () {
                              context.read<HomeController>().changeLike(
                                  product: state.singleProduct, index: 0);
                            },
                          )),
                    ],
                  ),
                ),
                Text(
                  (state.singleProduct?.name
                              ?.substring(0, 1)
                              .toUpperCase() ??
                          "") +
                      (state.singleProduct?.name?.substring(1) ?? ""),
                  style: Style.textStyleSemiBold(size: 22),
                ),
                12.h.verticalSpace,
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  child: Text(
                    NumberFormat.currency(
                            locale: 'uz',
                            symbol: "currency".tr(),
                            decimalDigits: 0)
                        .format(state.singleProduct?.price),
                    style: Style.textStyleNormal(
                        size: state.singleProduct?.discount != null &&
                                state.singleProduct?.discount != 0
                            ? 15.5.sp
                            : 16.sp,
                        isActive: state.singleProduct?.discount != null &&
                            state.singleProduct?.discount != 0),
                  ),
                ),
                state.singleProduct?.discount != null &&
                        state.singleProduct?.discount != 0
                    ? Padding(
                        padding:
                            const EdgeInsets.symmetric(horizontal: 12),
                        child: Text(
                          NumberFormat.currency(
                                  locale: 'uz',
                                  symbol: "currency".tr(),
                                  decimalDigits: 0)
                              .format((state.singleProduct?.price ?? 0) -
                                  (((state.singleProduct?.price ?? 0) /
                                              100)
                                          .toDouble() *
                                      (state.singleProduct?.discount ?? 0)
                                          .toDouble())),
                          style: Style.textStyleNormal(size: 15),
                        ),
                      )
                    : const SizedBox.shrink(),
                16.h.verticalSpace,
                Text("${state.singleProduct?.desc}"),
              ],
            ),
    );
  }
}
