import 'package:flutter/material.dart';
import '../../../utils/Style/style.dart';
import '../../../utils/constants.dart';

class MyDropDown extends StatelessWidget {
  final String? value;
  final String hint;
  final List list;
  final ValueChanged onChanged;

  const MyDropDown(
      {Key? key,
      this.value,
      required this.list,
      required this.onChanged,
      required this.hint})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField(
      hint: Text(
        hint,
        style: Style.textStyleNormal(textColor: kWhiteColor.withOpacity(0.7)),
      ),
      value: value,
      items: list.map((e) {
        return DropdownMenuItem(value: e, child: Text(e));
      }).toList(),
      onChanged: onChanged,
      dropdownColor: kGreenColor,
      iconEnabledColor: kWhiteColor,
      borderRadius: BorderRadius.circular(14),
      style: Style.textStyleNormal(textColor: kWhiteColor),
      decoration: Style.myDecoration(title: "Kategoriya"),
    );
  }
}
