import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import '../../../utils/constants.dart';
import '../../../utils/Style/style.dart';

class SearchFormField extends StatelessWidget {
  final TextEditingController controller;
  final ValueChanged<String?>? onchange;

  const SearchFormField({Key? key, required this.controller, this.onchange})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      onChanged: onchange,
      style: Style.textStyleNormal(textColor: kWhiteColor),
      decoration: InputDecoration(
          contentPadding:
              const EdgeInsets.symmetric(vertical: 12, horizontal: 12),
          prefixIconConstraints: const BoxConstraints(maxHeight: 18),
          prefixIcon: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: SvgPicture.asset("assets/svg/search.svg", height: 16),
          ),
          hintText: "Qidirish uchun yozing",
          hintStyle: Style.textStyleNormal(
              textColor: kWhiteColor.withOpacity(0.7), size: 15),
          filled: true,
          fillColor: kWhiteColor.withOpacity(0.2),
          border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide.none)),
    );
  }
}
