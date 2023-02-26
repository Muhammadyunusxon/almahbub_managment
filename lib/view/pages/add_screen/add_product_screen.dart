import 'package:almahbub_managment/domen/model/product_model/product_model.dart';
import 'package:almahbub_managment/view/utils/constants.dart';
import 'package:almahbub_managment/controller/product_controller.dart';
import 'package:almahbub_managment/view/pages/add_screen/widgets/category_dialog.dart';
import 'package:almahbub_managment/view/pages/add_screen/widgets/image_field.dart';
import 'package:almahbub_managment/view/pages/add_screen/widgets/my_drop_down.dart';
import 'package:almahbub_managment/view/utils/component/my_form_field.dart';
import 'package:almahbub_managment/view/pages/add_screen/widgets/type_dialog.dart';
import 'package:almahbub_managment/view/pages/general_connection_page.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

import '../../utils/Style/style.dart';

class AddProductScreen extends StatefulWidget {
  final ProductModel? product;

  const AddProductScreen({Key? key, this.product}) : super(key: key);

  @override
  State<AddProductScreen> createState() => _AddProductScreenState();
}

class _AddProductScreenState extends State<AddProductScreen> {
  late TextEditingController nameController;
  late TextEditingController descController;
  late TextEditingController discountController;
  late TextEditingController priceController;
  bool isLoading = false;

  @override
  void initState() {
    nameController = TextEditingController();
    descController = TextEditingController();
    discountController = TextEditingController();
    priceController = TextEditingController();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<ProductController>().getCategory();
      updateProduct();
    });

    super.initState();
  }

  bool isUpdate = false;

  updateProduct() {
    if (widget.product != null) {
      isUpdate = true;
      setState(() {});
      nameController.text = widget.product!.name ?? "";
      descController.text = widget.product!.desc ?? "";
      discountController.text = (widget.product!.discount ?? "").toString();
      priceController.text = (widget.product!.price ?? "").toString();
      context.read<ProductController>().setInitialType(widget.product!.type ?? '');
      context.read<ProductController>().getSingleCategory(widget.product!.category ?? "");
      context.read<ProductController>().setImagePath(widget.product!.image ?? '');
    }
  }

  @override
  void dispose() {
    nameController.dispose();
    descController.dispose();
    discountController.dispose();
    priceController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final state = context.watch<ProductController>();
    final event = context.read<ProductController>();
    return Scaffold(
      backgroundColor: kGreenColor,
      appBar: AppBar(
        backgroundColor: kGreenColor,
        title: Text(
          isUpdate ? "update".tr() : " Mahsulot qo'shish",
          style: Style.brandStyle(textColor: kWhiteColor, size: 20),
        ),
      ),
      body: WillPopScope(
        onWillPop: () {
          context.read<ProductController>().clearImage();
          Navigator.pop(context);
          return Future(() => false);
        },
        child: state.isLoading
            ? Center(
                child: CircularProgressIndicator(
                color: kWhiteColor.withOpacity(0.7),
              ))
            : SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                padding:
                    const EdgeInsets.symmetric(horizontal: 24, vertical: 24),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    ImageField(
                      isOnline: state.imagePath.contains("http"),
                      imagePath: context.watch<ProductController>().imagePath,
                    ),
                    18.h.verticalSpace,
                    MyFormFiled(
                      controller: nameController,
                      title: 'name'.tr(),
                      textInputAction: TextInputAction.next,
                    ),
                    18.h.verticalSpace,
                    MyFormFiled(
                      controller: descController,
                      title: 'desc'.tr(),
                      textInputAction: TextInputAction.next,
                    ),
                    18.h.verticalSpace,
                    MyFormFiled(
                      controller: priceController,
                      title: 'price'.tr(),
                      textInputAction: TextInputAction.next,
                      textInputType: TextInputType.number,
                      formatter: true,
                    ),
                    18.h.verticalSpace,
                    MyFormFiled(
                      controller: discountController,
                      title: 'discount'.tr(),
                      textInputAction: TextInputAction.next,
                      textInputType: TextInputType.number,
                      formatter: true,
                    ),
                    18.h.verticalSpace,
                    Row(
                      children: [
                        Expanded(
                          child: MyDropDown(
                            value: state.initialCategory,
                            list: state.listOfCategory,
                            onChanged: (value) {
                              event.setCategory(value.toString());
                            },
                            hint: 'change_category'.tr(),
                          ),
                        ),
                        IconButton(
                          splashRadius: 26,
                          onPressed: () {
                            showDialog(
                                context: context,
                                builder: (_) => const Dialog(
                                      backgroundColor: Colors.transparent,
                                      child: CategoryDialog(),
                                    ));
                          },
                          icon: const Icon(
                            Icons.add,
                            color: kWhiteColor,
                          ),
                        )
                      ],
                    ),
                    18.h.verticalSpace,
                    Row(
                      children: [
                        Expanded(
                            child: MyDropDown(
                          value: state.initialType,
                          list: state.listOfType,
                          onChanged: (value) {
                            event.setType(value);
                          },
                          hint: "change_type".tr(),
                        )),
                        IconButton(
                          splashRadius: 26,
                          onPressed: () {
                            showDialog(
                                context: context,
                                builder: (_) => const Dialog(
                                      backgroundColor: Colors.transparent,
                                      child: TypeDialog(),
                                    ));
                          },
                          icon: const Icon(
                            Icons.add,
                            color: kWhiteColor,
                          ),
                        )
                      ],
                    ),
                    18.h.verticalSpace,
                    state.addError
                        ? Text(
                            "is_error".tr(),
                            style: Style.textStyleNormal(
                                textColor: Style.redColor),
                          )
                        : const SizedBox.shrink(),
                    24.h.verticalSpace,
                    GestureDetector(
                        onTap: () async {
                          event.createProduct(
                            name: nameController.text,
                            desc: descController.text,
                            price: priceController.text,
                            discount: discountController.text,
                            id: widget.product?.id ?? "",
                            onSuccess: () {
                              Navigator.pushAndRemoveUntil(
                                  context,
                                  MaterialPageRoute(
                                      builder: (_) => const GeneralPage()),
                                  (route) => false);
                            },
                            isUpdate: isUpdate,
                          );
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12),
                            color: kWhiteColor.withOpacity(0.5),
                          ),
                          height: 55,
                          width: double.infinity,
                          child: state.isSaveLoading
                              ? const Center(
                                  child: CircularProgressIndicator(
                                  color: kGreenColor,
                                ))
                              : Center(
                                  child: Text(
                                    isUpdate ? "update".tr() : "add".tr(),
                                    style: Style.textStyleSemiBold(
                                        textColor: kGreenColor),
                                  ),
                                ),
                        )),
                    64.verticalSpace
                  ],
                ),
              ),
      ),
    );
  }
}
