import 'package:convex_bottom_bar/convex_bottom_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../constants.dart';

class BottomConvexBar extends StatelessWidget {
  final ValueChanged<int> onChanged;

  const BottomConvexBar({Key? key, required this.onChanged}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ConvexAppBar(
      color: kGreenColor,
      curve: Curves.bounceIn,
      elevation: 1,
      backgroundColor: kWhiteColor,
      activeColor: kGreenColor,
      shadowColor: kGreenColor,
      style: TabStyle.fixedCircle,
      items: [
        TabItem(
          icon: SvgPicture.asset("assets/svg/home.svg"),
          activeIcon:
              SvgPicture.asset("assets/svg/home.svg", color: kGreenColor),
        ),
        TabItem(
          icon: SvgPicture.asset("assets/svg/search2.svg",color: kTextDarkColor,),
          activeIcon:
              SvgPicture.asset("assets/svg/search2.svg", color: kGreenColor),
        ),
        TabItem(
          icon: Padding(
              padding: const EdgeInsets.all(16),
              child: SvgPicture.asset("assets/svg/add.svg")),
          activeIcon: Padding(
              padding: const EdgeInsets.all(16),
              child:
                  SvgPicture.asset("assets/svg/add.svg", color: kBrandColor)),
        ),
        TabItem(
          icon: SvgPicture.asset("assets/svg/comment.svg"),
          activeIcon: SvgPicture.asset("assets/svg/comment.svg",
              color: kGreenColor),
        ),
        TabItem(
          icon: SvgPicture.asset("assets/svg/favourite_outline.svg"),
          activeIcon:
              SvgPicture.asset("assets/svg/favourite_outline.svg", color: kGreenColor),
        ),
      ],
      initialActiveIndex: 0,
      onTap: onChanged,
    );
  }
}
