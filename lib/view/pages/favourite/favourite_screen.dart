import 'package:almahbub_managment/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

import '../../../controller/home_controller.dart';
import '../../../size_config.dart';
import '../../component/my_product.dart';
import '../../style/style.dart';

class FavouriteScreen extends StatelessWidget {
  const FavouriteScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final state = context.watch<HomeController>();
    final event = context.read<HomeController>();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      event.getFavourites();
    });
    SizeConfig().init(context);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: kGreenColor,
        title: Text(
          "Saralanganlar",
          style: Style.brandStyle(textColor: kWhiteColor, size: 22),
        ),
      ),
      body: state.listOfFavouriteProduct.isEmpty
          ? Column(
              children: [
              ((SizeConfig.screenHeight!)~/5).toInt().verticalSpace,
                Padding(
                  padding: EdgeInsets.only(
                      left: SizeConfig.screenWidth! / 7,
                      right: SizeConfig.screenWidth! / 3),
                  child: Image.asset("assets/images/favourite.png"),
                ),
                Text(
                  "Saralang"
                      "anlar mavjud emas",
                  style: Style.textStyleNormal(textColor: Style.semiGreyColor),
                )
              ],
            )
          : GridView.builder(
              physics: const BouncingScrollPhysics(),
              shrinkWrap: true,
              itemCount: state.listOfFavouriteProduct.length,
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 24),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 18,
                  mainAxisExtent: 230,
                  mainAxisSpacing: 16),
              itemBuilder: (context, index) {
                return MyProduct(
                  model: state.listOfFavouriteProduct[index],
                  index: index,
                  isFavPage: true,
                );
              }),
    );
  }
}
