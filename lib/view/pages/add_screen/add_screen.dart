import 'package:almahbub_managment/constants.dart';
import 'package:almahbub_managment/controller/product_controller.dart';
import 'package:almahbub_managment/view/pages/add_screen/widgets/category_dialog.dart';
import 'package:almahbub_managment/view/pages/add_screen/widgets/image_field.dart';
import 'package:almahbub_managment/view/pages/add_screen/widgets/my_drop_down.dart';
import 'package:almahbub_managment/view/pages/add_screen/widgets/my_form_field.dart';
import 'package:almahbub_managment/view/pages/add_screen/widgets/type_dialog.dart';
import 'package:almahbub_managment/view/style/style.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import '../home_screen/home_page.dart';

class AddScreen extends StatefulWidget {
  const AddScreen({Key? key}) : super(key: key);

  @override
  State<AddScreen> createState() => _AddScreenState();
}

class _AddScreenState extends State<AddScreen> {
  late  TextEditingController nameController ;
  late  TextEditingController descController ;
  late  TextEditingController discountController ;
  late  TextEditingController priceController;
  final FirebaseFirestore firestore = FirebaseFirestore.instance;
  final ImagePicker _picker = ImagePicker();
  String? imagePath;
  bool isLoading = false;

  @override
  void initState() {
    nameController =TextEditingController();
    descController =TextEditingController();
    discountController =TextEditingController();
    priceController =TextEditingController();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<ProductController>().getCategory();
    });
    super.initState();
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
          "Mahsulot qo'shish",
          style: Style.textStyleNormal(textColor: kWhiteColor, size: 18),
        ),
      ),
      body: state.isLoading
          ?  Center(
              child: CircularProgressIndicator(
              color: kWhiteColor.withOpacity(0.7),
            ))
          : SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 24),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  const ImageField(),
                  18.verticalSpace,
                  MyFormFiled(
                    controller: nameController,
                    title: 'Nomi',
                  ),
                  18.verticalSpace,
                  MyFormFiled(
                    controller: descController,
                    title: 'Tavsifi',
                  ),
                  18.verticalSpace,
                  MyFormFiled(
                    controller: priceController,
                    title: 'Narxi',
                  ),
                  18.verticalSpace,
                  MyFormFiled(
                    controller: discountController,
                    title: 'Chegirma',
                  ),
                  18.verticalSpace,
                  Row(
                    children: [
                      Expanded(
                        child: MyDropDown(
                          value: state.listOfCategory.first,
                          list: state.listOfCategory,
                          onChanged: (value) {
                            event.setCategory(value.toString());
                          },
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
                  18.verticalSpace,
                  Row(
                    children: [
                      Expanded(
                          child: MyDropDown(
                        value: state.listOfType.first,
                        list: state.listOfType,
                        onChanged: (value) {
                          event.setType(value);
                        },
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
                  48.verticalSpace,
                  GestureDetector(
                      onTap: () async {
                        event.createProduct(
                          name: nameController.text,
                          desc: descController.text,
                          price: priceController.text,
                          discount: discountController.text,
                          onSuccess: () {
                            Navigator.pushAndRemoveUntil(
                                context,
                                MaterialPageRoute(
                                    builder: (_) => const HomePage()),
                                (route) => false);
                          },
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
                                  "Save",
                                  style: Style.textStyleSemiBold(
                                      textColor: kGreenColor),
                                ),
                              ),
                      ))
                ],
              ),
            ),
    );
  }
}
