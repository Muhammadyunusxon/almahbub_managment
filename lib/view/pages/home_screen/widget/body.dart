import 'package:almahbub_managment/controller/home_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

import '../../../../constants.dart';
import '../../../component/my_product.dart';
import '../../../style/style.dart';
import 'discounts.dart';

class Body extends StatelessWidget {
  const Body({super.key});

  @override
  Widget build(BuildContext context) {
    final state = context.watch<HomeController>();
    final event = context.read<HomeController>();
    return ListView(
      physics: const BouncingScrollPhysics(),
      padding: const EdgeInsets.symmetric(vertical: 24),
      children: <Widget>[
        Discounts(
          onTap: () {},
        ),
        12.verticalSpace,
        Row(
          children: [
            26.horizontalSpace,
            Text(
              'Mahsulotlar',
              style: Style.textStyleNormal(),
            ),
            const Spacer(),
            TextButton(
              onPressed: () {},
              child: Text(
                'Hammasi',
                style: Style.textStyleNormal(
                    size: 14.5, textColor: kTextGreenColor),
              ),
            ),
            12.horizontalSpace,
          ],
        ),
        GridView.builder(
            physics: const NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemCount: state.listOfProduct.length,
            padding: const EdgeInsets.symmetric(horizontal: 24),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2, crossAxisSpacing: 18, mainAxisExtent: 230,mainAxisSpacing: 16),
            itemBuilder: (context, index) {
              return MyProduct(
                model: state.listOfProduct[index], index: index,
              );
            })
      ],
    );
  }
}
