import 'package:flutter/material.dart';
import 'package:pattern_formatter/numeric_formatter.dart';

class CustomTextFrom extends StatelessWidget {
  final TextEditingController controller;
  final String label;
  final TextInputType keyboardType;

  const CustomTextFrom(
      {Key? key,
      required this.controller,
      required this.label,
      this.keyboardType = TextInputType.text})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      keyboardType: keyboardType,
      inputFormatters: [
        ThousandsFormatter()
      ],
      decoration: InputDecoration(
          labelText: label,
          border: OutlineInputBorder(),
          enabledBorder: OutlineInputBorder(),
          focusedBorder: OutlineInputBorder()),
    );
  }
}
