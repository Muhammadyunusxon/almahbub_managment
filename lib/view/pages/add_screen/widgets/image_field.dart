import 'dart:io';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../utils/constants.dart';
import '../../../../controller/product_controller.dart';
import 'my_dialog.dart';
class ImageField extends StatelessWidget {
  const ImageField({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  context.watch<ProductController>().imagePath == ''
        ? GestureDetector(
        onTap: () {
          showDialog(
              context: context,
              builder: (_) {
                return const Dialog(
                  backgroundColor: Colors.transparent,
                  child: MyDialog(),
                );
              });
        },
        child: SizedBox(
          height: 150,
          width: 150,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(14),
            child: Image.asset(
              "assets/images/noimage.jpg",
              fit: BoxFit.cover,
            ),
          ),
        ))
        : Stack(
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: SizedBox(
              height: 150,
              width: 150,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(14),
                child: Image.file(
                  File(context
                      .watch<ProductController>()
                      .imagePath),
                  fit: BoxFit.cover,
                ),
              )),
        ),
        Positioned(
          bottom: 0,
          right: 0,
          child: Container(
            height: 38,
            width: 38,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: kGreenColor),
            child: IconButton(
              splashRadius: 24,
              icon: const Icon(
                Icons.edit,
                color: kWhiteColor,
                size: 21,
              ),
              onPressed: () {
                showDialog(
                    context: context,
                    builder: (_) {
                      return const Dialog(
                        backgroundColor: Colors.transparent,
                        child: MyDialog(),
                      );
                    });
              },
            ),
          ),
        )
      ],
    );
  }
}
