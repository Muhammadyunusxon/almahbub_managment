import 'package:almahbub_managment/controller/home_controller.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../utils/component/my_image_network.dart';
import '../../../utils/constants.dart';

class MyBanner extends StatelessWidget {
  final Function onTap;

  const MyBanner({Key? key, required this.onTap}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final state = context.watch<HomeController>();
    final size = MediaQuery.of(context).size;
    return SizedBox(
      height: 200,
      child: ListView.builder(
          physics: const BouncingScrollPhysics(),
          padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 12),
          scrollDirection: Axis.horizontal,
          itemCount: state.listOfBanners.length,
          itemBuilder: (context, index) {
            return Padding(
              padding: const EdgeInsets.only(right: 18),
              child: GestureDetector(
                onTap: onTap(),
                child: Container(
                  width: size.width - 65,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      color: kWhiteColor),
                  child: CustomImageNetwork(
                    radius: 12,
                    image: state.listOfBanners[index].image,
                  ),
                ),
              ),
            );
          }),
    );
  }
}
