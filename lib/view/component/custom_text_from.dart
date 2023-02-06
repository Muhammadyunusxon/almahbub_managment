import 'package:flutter/material.dart';
import 'package:pattern_formatter/numeric_formatter.dart';

class CustomTextFrom extends StatelessWidget {
  final TextEditingController controller;
  final String label;
  final TextInputType keyboardType;
  final FocusNode? node;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final ValueChanged<String>? onChange;

  const CustomTextFrom(
      {Key? key,
      required this.controller,
      required this.label,
      this.keyboardType = TextInputType.text, this.node, this.prefixIcon, this.suffixIcon,  this.onChange})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      onChanged: onChange,
      keyboardType: keyboardType,
      focusNode: node,
      inputFormatters: [
        ThousandsFormatter()
      ],
      decoration: InputDecoration(
        prefixIcon: prefixIcon,
        suffixIcon: suffixIcon,
          labelText: label,
          border: const OutlineInputBorder(),
          enabledBorder: const OutlineInputBorder(),
          focusedBorder: const OutlineInputBorder()),
    );
  }
}
