import 'package:flutter/material.dart';

import '../../../../constants.dart';
import '../../../style/style.dart';

class MyFormFiled extends StatelessWidget {
  final TextEditingController controller;
  final String title;

  const MyFormFiled({Key? key, required this.controller, required this.title})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      style: Style.textStyleNormal(textColor: kWhiteColor),
      decoration: Style.myDecoration(title: title),
    );
  }
}
