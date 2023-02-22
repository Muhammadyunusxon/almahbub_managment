import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

import '../../../controller/home_controller.dart';
import '../../../domen/model/category_model/category_model.dart';
import '../../utils/component/my_product.dart';
import '../../utils/constants.dart';

class CategoryProducts extends StatefulWidget {
  final CategoryModel categoryModel;

  const CategoryProducts({Key? key, required this.categoryModel})
      : super(key: key);

  @override
  State<CategoryProducts> createState() => _CategoryProductsState();
}

class _CategoryProductsState extends State<CategoryProducts> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<HomeController>().getOneCategory(widget.categoryModel);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final state = context.watch<HomeController>();
    return Scaffold(
      backgroundColor: kMediumColor,
      appBar: AppBar(
        backgroundColor: kGreenColor,
      ),
      body: SafeArea(
        child: state.isCategoryLoading
            ? const Center(
                child: CircularProgressIndicator(
                color: kBrandColor,
              ))
            : GridView.builder(
                physics: const BouncingScrollPhysics(),
                shrinkWrap: true,
                itemCount: state.listOfCategoryProduct.length,
                padding: EdgeInsets.symmetric(horizontal: 20.w,vertical: 24.h),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 18.w,
                    mainAxisExtent: 260.h,
                    mainAxisSpacing: 16.h),
                itemBuilder: (context, index) {
                  return MyProduct(
                    model: state.listOfCategoryProduct[index],
                    index: index,
                    onLike: () {
                      context
                          .read<HomeController>()
                          .changeLike(index: index, isCategory: true);
                    },
                    onDelete: () {
                      context.read<HomeController>().deleteProduct(
                          docId: state.listOfCategoryProduct[index].id ?? "",
                          image:
                              state.listOfCategoryProduct[index].image ?? "");
                    },
                  );
                }),
      ),
    );
  }
}
