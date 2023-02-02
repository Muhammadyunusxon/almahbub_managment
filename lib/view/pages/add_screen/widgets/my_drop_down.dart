import 'package:flutter/material.dart';
import '../../../../constants.dart';
import '../../../style/style.dart';

class MyDropDown extends StatelessWidget {
  final String value;
  final List list;
  final ValueChanged onChanged;
  const MyDropDown({Key? key, required this.value, required this.list, required this.onChanged}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  DropdownButtonFormField(
      value: value,
      items:
          list.map(
              (e) {
                return DropdownMenuItem(value: e, child: Text(e));
              })
          .toList(),
      onChanged:onChanged,
      dropdownColor: kGreenColor,
      iconEnabledColor: kWhiteColor,
      borderRadius: BorderRadius.circular(14),
      style: Style.textStyleNormal(
          textColor: kWhiteColor),
      decoration: Style.myDecoration(title: "Kategoriya"),
    );
  }
}
