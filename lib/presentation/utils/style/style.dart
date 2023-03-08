import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../constants.dart';

abstract class Style {
  Style._();

  static const mediumGreyColor = Color(0xffF1F4F3);
  static const semiGreyColor = Color(0xff8F92A1);
  static const yellowColor = Color(0xffFBA808);
  static const formColor = Color(0xff8F92A1);
  static const redColor = Color(0xffEF4B5F);
  static const shimmerBaseColor = Color(0x80FFFFFF);
  static const shimmerHighlightColor = Color(0x33FFFFFF);
  static const shimmerColor = Color(0x3348319D);
  static const productBgColor = Color(0xffFFDE9B);
  static const blackColor = Colors.black;

  static LinearGradient primaryGradiant = const LinearGradient(
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
      colors: [kTextGreenColor, kGreenColor]);

  static LinearGradient secondaryGradiant = const LinearGradient(
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
      colors: [mediumGreyColor, mediumGreyColor]);

  static textStyleNormal(
      {double size = 16,
      Color textColor = kTextDarkColor,
      bool isActive = false}) {
    return GoogleFonts.manrope(
      fontSize: size,
      color: textColor,
      fontWeight: FontWeight.normal,
      decoration: isActive ? TextDecoration.lineThrough : TextDecoration.none,
    );
  }

  static textStyleSemiBold(
      {double size = 16, Color textColor = kTextDarkColor}) {
    return GoogleFonts.manrope(
      fontSize: size,
      color: textColor,
      fontWeight: FontWeight.w600,
      decoration: TextDecoration.none,
    );
  }

  static textStyleBold({double size = 18, Color textColor = kTextDarkColor}) {
    return GoogleFonts.manrope(
      fontSize: size,
      color: textColor,
      fontWeight: FontWeight.bold,
      decoration: TextDecoration.none,
    );
  }

  static textStyleRegular(
      {double size = 16, Color textColor = kTextDarkColor}) {
    return GoogleFonts.manrope(
      fontSize: size,
      color: textColor,
      fontWeight: FontWeight.w400,
      decoration: TextDecoration.none,
    );
  }

  static brandStyle({double size = 26, Color textColor = kTextDarkColor}) {
    return GoogleFonts.k2d(
        fontSize: size,
        color: textColor,
        fontWeight: FontWeight.w500,
        decoration: TextDecoration.none);
  }

  static brandStyleBold({double size = 44, Color textColor = kYellowColor}) {
    return GoogleFonts.k2d(
        fontSize: size,
        color: textColor,
        fontWeight: FontWeight.w600,
        decoration: TextDecoration.none);
  }

  static bottomText({double size = 16, Color textColor = kGreenColor}) {
    return GoogleFonts.sourceSansPro(
        fontSize: size, fontWeight: FontWeight.w600, color: textColor);
  }

  static myDecoration(
      {required String title,
      Color? titleColor,
      Color? fillColor,
      Widget? prefixIcon,
      Widget? suffixIcon,
      Color? borderColor}) {
    return InputDecoration(
      contentPadding: const EdgeInsets.symmetric(vertical: 12, horizontal: 12),
      prefixIconConstraints: const BoxConstraints(maxHeight: 18),
      hintText: title,
      prefixIcon: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12),
          child: prefixIcon),
      suffixIcon: suffixIcon,
      hintStyle: Style.textStyleNormal(
          textColor: titleColor ?? kWhiteColor.withOpacity(0.6), size: 15),
      filled: true,
      fillColor: fillColor ?? kWhiteColor.withOpacity(0.2),
      border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(color: borderColor ?? Colors.transparent)),
      focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(color: borderColor ?? Colors.transparent)),
      enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(color: borderColor ?? Colors.transparent)),
    );
  }
}
