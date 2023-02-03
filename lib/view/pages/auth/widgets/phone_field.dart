import 'package:flutter/material.dart';

import '../../../style/style.dart';

class PhoneField extends StatelessWidget {
  final TextEditingController phoneController;

  const PhoneField({Key? key, required this.phoneController})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 6, bottom: 6),
          child: Text(
            "Telefon raqamni kiriting",
            style: Style.textStyleNormal(
                size: 14, textColor: Style.semiGreyColor),
          ),
        ),
        TextFormField(
          controller: phoneController,
          style: Style.textStyleNormal(),
          decoration: InputDecoration(
            contentPadding: const EdgeInsets.symmetric(
                vertical: 16, horizontal: 20),
            filled: true,
            fillColor: Style.mediumGreyColor,
            border: OutlineInputBorder(
                borderSide: BorderSide.none,
                borderRadius: BorderRadius.circular(10)),
            focusedBorder: OutlineInputBorder(
                borderSide: BorderSide.none,
                borderRadius: BorderRadius.circular(10)),
            enabledBorder: OutlineInputBorder(
                borderSide: BorderSide.none,
                borderRadius: BorderRadius.circular(10)),
          ),
        ),
      ],
    );
  }
}
