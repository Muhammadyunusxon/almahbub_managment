import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../utils/component/my_image_network.dart';
import '../../../utils/constants.dart';
import 'my_dialog.dart';

class ImageField extends StatelessWidget {
  final bool isOnline;
  final String imagePath;

  const ImageField({Key? key, required this.isOnline, required this.imagePath})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return imagePath == ''
        ? GestureDetector(
            onTap: () {
              showDialog(
                  context: context,
                  builder: (_) {
                    return const Dialog(
                        backgroundColor: Colors.transparent, child: MyDialog());
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
              isOnline
                  ? CustomImageNetwork(
                      image: imagePath,
                      radius: 14.r,
                      height: 150,
                      width: 150,
                    )
                  : Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: SizedBox(
                          height: 150,
                          width: 150,
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(14.r),
                            child: Image.file(
                              File(imagePath),
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
                      borderRadius: BorderRadius.circular(12),
                      color: kGreenColor.withOpacity(0.9)),
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
