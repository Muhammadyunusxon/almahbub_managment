

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../constants.dart';
import '../../../style/style.dart';
import 'search_form_field.dart';

class MyAppBar extends StatelessWidget {
  const MyAppBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  Container(
      height: 175,
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 24),
      color: kGreenColor,
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
              IconButton(
                splashRadius: 24,
                onPressed: () {
                  print("Navigator");
                },
                icon: SizedBox(
                    height: 18,
                    width: 18,
                    child: Image.asset("assets/images/menu.png")),
              )
            ],
          ),
          const SizedBox(height: 7),
          Row(
            children: [
              SvgPicture.asset('assets/svg/location.svg', height: 14),
              const SizedBox(width: 5),
              Text(
                "Yangiyer bozori",
                style: Style.textStyleNormal(
                    textColor: kWhiteColor, size: 14),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
