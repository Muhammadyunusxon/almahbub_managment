import 'dart:math';

import 'package:almahbub_managment/view/pages/add_screen/add_product_screen.dart';
import 'package:almahbub_managment/view/utils/Style/style.dart';
import 'package:almahbub_managment/view/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AddScreen extends StatelessWidget {
  const AddScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: kWhiteColor,
      height: double.infinity,
      width: double.infinity,
      child: GridView(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          mainAxisExtent: 100,
            crossAxisCount: 1, crossAxisSpacing: 12, mainAxisSpacing: 12),
        children: [
          Container(
            padding: const EdgeInsets.symmetric(vertical: 12),
            decoration: BoxDecoration(
                color:
                    Colors.primaries[Random().nextInt(Colors.primaries.length)],
                borderRadius: BorderRadius.circular(16.r)),
            child: Center(
                child: Text("Banner qo'shish", style: Style.textStyleNormal())),
          ),
          GestureDetector(
            onTap: (){
              Navigator.of(context).push(MaterialPageRoute(builder: (_)=> AddProductScreen()));
            },
            child: Container(
              padding: const EdgeInsets.symmetric(vertical: 12),
              decoration: BoxDecoration(
                  color:
                      Colors.primaries[Random().nextInt(Colors.primaries.length)],
                  borderRadius: BorderRadius.circular(16.r)),
              child: Center(
                  child: Text(
                "Mahsulot qo'shish",
                style: Style.textStyleNormal(),
              )),
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(vertical: 12),
            decoration: BoxDecoration(
                color:
                    Colors.primaries[Random().nextInt(Colors.primaries.length)],
                borderRadius: BorderRadius.circular(16.r)),
            child: Center(
                child: Text(
              "Barcha Chegirmalarni o'chirish",
              style: Style.textStyleNormal(),
            )),
          ),
        ],
      ),
    );
  }
}
