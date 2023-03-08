import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

import '../../../application/home_controller.dart';
import '../../utils/Style/style.dart';
import '../../utils/component/my_image_network.dart';
import '../../utils/component/search_form_field.dart';
import '../../utils/constants.dart';
import '../../utils/size_config.dart';
import 'category_products.dart';

class CategoryPage extends StatefulWidget {
  const CategoryPage({Key? key}) : super(key: key);

  @override
  State<CategoryPage> createState() => _CategoryPageState();
}

class _CategoryPageState extends State<CategoryPage> {
  final TextEditingController search = TextEditingController();

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<HomeController>().getCategory();
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
                    mainAxisExtent: 126,
                    mainAxisSpacing: 12.h,
                    crossAxisSpacing: 12.w),
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (_) => CategoryProducts(
                                categoryModel: state.listOfCategory[index],
                              )));
                    },
                    child: Column(
                      children: [
                        Container(
                          margin: EdgeInsets.all(8.r),
                          width: SizeConfig.screenWidth! / 3,
                          height: SizeConfig.screenWidth! / 3 - 42,
                          padding: EdgeInsets.all(6.r),
                          decoration: BoxDecoration(
                              color: const Color(0xff3A860A).withOpacity(0.1),
                              borderRadius: BorderRadius.circular(10.r)),
                          child: Column(
                            children: [
                              state.listOfCategory[index].image == null
                                  ? const SizedBox.shrink()
                                  : CustomImageNetwork(
                                      image:
                                          state.listOfCategory[index].image ??
                                              "",
                                      boxFit: BoxFit.contain,
                                      height:
                                          SizeConfig.screenWidth! / 3 - 60,
                                      width: SizeConfig.screenWidth! / 3 - 60,
                                    )
                            ],
                          ),
                        ),
                        Text(
                          state.listOfCategory[index].name ?? "",
                          style: Style.textStyleNormal(size: 15.5.sp),
                        )
                      ],
                    ),
                  );
                }),
          )
        ],
      ),
    );
  }
}
