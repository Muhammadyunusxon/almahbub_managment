import 'package:flutter/material.dart';

import '../../../utils/constants.dart';
import '../../../utils/Style/style.dart';

class MyFormFiled extends StatelessWidget {
  final TextEditingController controller;
  final String title;
  final TextInputAction textInputAction;

  const MyFormFiled({Key? key, required this.controller, required this.title, this.textInputAction=TextInputAction.done})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      textInputAction: textInputAction,
      controller: controller,
      style: Style.textStyleNormal(textColor: kWhiteColor),
      decoration: Style.myDecoration(title: title),
    );
  }
}
