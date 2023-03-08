import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../pages/main/btm_nav_item.dart';
import '../../pages/main/menu.dart';
import '../../pages/main/rive_utils.dart';
import '../blur.dart';
import '../constants.dart';

class BottomConvexBar extends StatelessWidget {
  final ValueChanged<int> onChanged;
  final int selectIndex;
  final double animValue;
  final bool isReverse;

  const BottomConvexBar(
      {Key? key,
      required this.onChanged,
      required this.selectIndex,
      required this.animValue,
      required this.isReverse})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(seconds: 5),
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 24.w),
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: backgroundColor2.withOpacity(0.3),
              offset: const Offset(0, 20),
              blurRadius: 20.r,
            ),
          ],
        ),
        child: FrostedGlassBox(
          radius: isReverse ? 20 : 18,
          sigmaXY: 6,
          colorList: [
            backgroundColor2.withOpacity(0.75),
            backgroundColor2.withOpacity(0.75),
          ],
          theHeight: 62,
          theWidth: isReverse ? 62 : null,
          color: backgroundColor2,
          theChild:Padding(
                  padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 9),
                  child: isReverse
                      ? BtmNavItem(
                    navBar: bottomNavItems.last,
                    press: () {
                      RiveUtils.changeSMIBoolState(
                          bottomNavItems.last.rive.status!);
                      onChanged(bottomNavItems.length - 1);
                    },
                    riveOnInit: (artBoard) {
                      bottomNavItems.last.rive.status = RiveUtils.getRiveInput(
                          artBoard,
                          stateMachineName:
                          bottomNavItems.last.rive.stateMachineName);
                    },
                    selectedNav: bottomNavItems[selectIndex],
                  )
                      :  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      ...List.generate(
                        bottomNavItems.length,
                        (index) {
                          Menu navBar = bottomNavItems[index];
                          return BtmNavItem(
                            navBar: navBar,
                            press: () {
                              RiveUtils.changeSMIBoolState(navBar.rive.status!);
                              onChanged(index);
                            },
                            riveOnInit: (artBoard) {
                              navBar.rive.status = RiveUtils.getRiveInput(
                                  artBoard,
                                  stateMachineName:
                                      navBar.rive.stateMachineName);
                            },
                            selectedNav: bottomNavItems[selectIndex],
                          );
                        },
                      ),
                    ],
                  ),
                ),
        ),
      ),
    );
  }
}
