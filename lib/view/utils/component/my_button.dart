import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../controller/auth_controller.dart';
import '../constants.dart';
import '../style/style.dart';

class MyButton extends StatelessWidget {
  final String title;
  final bool isActive;
  final bool isLoading;
  final VoidCallback onTap;

  const MyButton(
      {Key? key,
      required this.title,
      this.isActive = true,
      required this.onTap,
      this.isLoading = false})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 44,
        decoration: BoxDecoration(
          color: isActive ? kYellowColor : kYellowColor.withOpacity(0.75),
          borderRadius: BorderRadius.circular(8),
        ),
        child: context.watch<AuthController>().isLoading
            ? const Center(
                child: Padding(
                  padding: EdgeInsets.all(4.0),
                  child: CircularProgressIndicator(
                    color: kWhiteColor,
                    strokeWidth: 3,
                  ),
                ),
              )
            : Center(
                child: Text(
                title,
                style: Style.textStyleSemiBold(textColor: kWhiteColor),
              )),
      ),
    );
  }
}
