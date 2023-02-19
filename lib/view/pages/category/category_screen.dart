import 'package:almahbub_managment/view/utils/constants.dart';
import 'package:almahbub_managment/view/utils/size_config.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

import '../../../controller/home_controller.dart';
import '../../utils/Style/style.dart';
import '../../utils/component/my_image_network.dart';
import '../home_screen/widget/search_form_field.dart';

class CategoryScreen extends StatefulWidget {
  const CategoryScreen({Key? key}) : super(key: key);

  @override
  State<CategoryScreen> createState() => _CategoryScreenState();
}

class _CategoryScreenState extends State<CategoryScreen> {
  final TextEditingController search = TextEditingController();

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<HomeController>().getCategory(isLimit: false);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final state = context.watch<HomeController>();
    final event = context.read<HomeController>();
    SizeConfig().init(context);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: kGreenColor,
        title: Text(
          "Kategoriya",
          style: Style.brandStyle(size: 20, textColor: kWhiteColor),
        ),
      ),
      body: Column(
        children: [
          Container(
            color: kGreenColor,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: SearchFormField(
                controller: search,
                onchange: (s) {
                  event.searchCategory(s ?? '');
                },
              ),
            ),
          ),
          Expanded(
            child: GridView.builder(
                shrinkWrap: true,
                itemCount: state.listOfCategory.length,
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 18),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                    mainAxisExtent: 125.h,
                    mainAxisSpacing: 12.h,
                    crossAxisSpacing: 12.w),
                itemBuilder: (context, index) {
                  return Column(
                    children: [
                      Container(
                        margin: EdgeInsets.all(8.r),
                        width: SizeConfig.screenWidth! / 3,
                        height: SizeConfig.screenWidth! / 3 - 42,
                        padding: const EdgeInsets.all(6),
                        decoration: BoxDecoration(
                            color: const Color(0xff3A860A).withOpacity(0.1),
                            borderRadius: BorderRadius.circular(10)),
                        child: Column(
                          children: [
                            state.listOfCategory[index].image == null
                                ? const SizedBox.shrink()
                                : CustomImageNetwork(
                                    image:
                                        state.listOfCategory[index].image ?? "",
                                    boxFit: BoxFit.contain,
                                    height: SizeConfig.screenWidth! / 3 - 60,
                                    width: SizeConfig.screenWidth! / 3 - 60,
                                  )
                          ],
                        ),
                      ),
                      Text(
                        state.listOfCategory[index].name ?? "",
                      )
                    ],
                  );
                }),
          )
        ],
      ),
    );
  }
}
