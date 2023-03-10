import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../../../utils/Style/style.dart';
import '../../../utils/constants.dart';

// ignore: must_be_immutable
class SplashBody extends StatelessWidget {
  // ignore: prefer_typing_uninitialized_variables
  final bool? isOnline;
  const SplashBody({Key? key,  required this.isOnline}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      backgroundColor: kGreenColor,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const Spacer(flex: 10),
          Center(
            child: Text(
              'AL MAHBUB',
              style: Style.brandStyleBold(),
            ),
          ),
          const Spacer(),
          isOnline == true
              ? const SizedBox.shrink()
              : isOnline == false
              ? Center(
            child: Text(
              'internet'.tr(),
              style: Style.brandStyle(
                  size: 18, textColor: kYellowColor),
            ),
          )
              : const CircularProgressIndicator(
            color: kYellowColor,
          ),
          const Spacer(flex: 10),
        ],
      ),
    );
  }
}
