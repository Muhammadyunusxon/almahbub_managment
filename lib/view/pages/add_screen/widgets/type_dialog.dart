import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

import '../../../utils/constants.dart';
import '../../../../controller/product_controller.dart';
import '../../../utils/Style/style.dart';
import 'my_form_field.dart';

class TypeDialog extends StatefulWidget {
  const TypeDialog({Key? key}) : super(key: key);

  @override
  State<TypeDialog> createState() => _TypeDialogState();
}

class _TypeDialogState extends State<TypeDialog> {
  late TextEditingController _textEditingController;

  @override
  void initState() {
    _textEditingController = TextEditingController();
    super.initState();
  }
  @override
  void dispose() {
    _textEditingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final state = context.watch<ProductController>();
    final event = context.read<ProductController>();
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
          color: kGreenColor, borderRadius: BorderRadius.circular(14)),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          12.verticalSpace,
          MyFormFiled(controller: _textEditingController, title: "O'lchov birligi"),
          18.verticalSpace,
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              GestureDetector(
                onTap: () {
                  Navigator.pop(context);
                },
                child: Container(
                  padding:
                  const EdgeInsets.symmetric(vertical: 8, horizontal: 18),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    color: kWhiteColor.withOpacity(0.5),
                  ),
                  child: Text(
                    "Cencel",
                    style: Style.textStyleSemiBold(
                        textColor: kGreenColor, size: 14),
                  ),
                ),
              ),
              GestureDetector(
                onTap: () {
                  event.addType(name: _textEditingController.text, onSuccess: () {
                    Navigator.pop(context);
                  });
                },
                child: Container(
                  padding:
                  const EdgeInsets.symmetric(vertical: 8, horizontal: 18),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    color: kWhiteColor.withOpacity(0.5),
                  ),
                  child:state.isSaveCategoryLoading? const CircularProgressIndicator(color: kGreenColor,strokeWidth: 3,): Text(
                    "OK",
                    style: Style.textStyleSemiBold(
                        textColor: kGreenColor, size: 14),
                  ),
                ),
              )
            ],
          ),
        ],
      ),
    );
  }
}
