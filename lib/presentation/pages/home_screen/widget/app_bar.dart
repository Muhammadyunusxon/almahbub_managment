import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

import '../../../utils/constants.dart';
import '../../../utils/Style/style.dart';
import '../../main/main_page.dart';
import '../location_map.dart';

class MyAppBar extends StatelessWidget {
  const MyAppBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 165,
      width: double.infinity,
      padding: EdgeInsets.symmetric(horizontal: 28.w, vertical: 24),
      color: kGreenColor,
      child: Column(
        children: [
          Row(
            children: [
              RichText(
                  text: TextSpan(children: [
                TextSpan(
                    text: "Al",
                    style: Style.brandStyle(textColor: kWhiteColor)),
                TextSpan(
                    text: " Mahbub",
                    style: Style.brandStyle(textColor: kYellowColor)),
              ])),
              const Spacer(),
              Row(
                children: [
                  TextButton(
                      onPressed: () {
                        context.setLocale(const Locale('en', 'US'));
                        Navigator.of(context).pushAndRemoveUntil(
                            MaterialPageRoute(builder: (_) => const MainPage()),
                            (route) => false);
                      },
                      child: Text(
                        "En",
                        style: Style.textStyleNormal(textColor: kWhiteColor),
                      )),
                  TextButton(
                      onPressed: () {
                        context.setLocale(const Locale('uz', 'UZ'));
                        Navigator.of(context).pushAndRemoveUntil(
                            MaterialPageRoute(builder: (_) => const MainPage()),
                            (route) => false);
                      },
                      child: Text(
                        "Uz",
                        style: Style.textStyleNormal(textColor: kWhiteColor),
                      ))
                ],
              ),
              IconButton(
                splashRadius: 24,
                onPressed: () {},
                icon: SizedBox(
                    height: 18,
                    width: 18,
                    child: Image.asset("assets/images/menu.png")),
              )
            ],
          ),
          5.verticalSpace,
          GestureDetector(
              onTap: () {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (_) => const YandexLocationMapPage()));
              },
              child: Row(
                children: [
                  SvgPicture.asset('assets/svg/location.svg', height: 14),
                  const SizedBox(width: 5),
                  Text(
                    "location".tr(),
                    style:
                        Style.textStyleNormal(textColor: kWhiteColor, size: 14),
                  ),
                ],
              )),
        ],
      ),
    );
  }
}
