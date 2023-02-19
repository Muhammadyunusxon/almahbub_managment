import 'package:almahbub_managment/view/utils/component/diss_keyboard.dart';
import 'package:almahbub_managment/view/utils/constants.dart';
import 'package:almahbub_managment/controller/home_controller.dart';
import 'package:almahbub_managment/view/pages/home_screen/widget/app_bar.dart';
import 'package:almahbub_managment/view/pages/home_screen/widget/body.dart';
import 'package:almahbub_managment/view/pages/home_screen/widget/search_form_field.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late TextEditingController searchController;

  @override
  void initState() {
    searchController = TextEditingController();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<HomeController>()
        ..getBanners()
        ..getProduct()
        ..getCategory();
    });

    super.initState();
  }

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return OnUnFocusTap(
      child: Scaffold(
        backgroundColor: kBGColor,
        body: CustomScrollView(
          physics: const BouncingScrollPhysics(),
          slivers: [
            SliverAppBar(
              backgroundColor: kGreenColor,
              toolbarHeight: 72,
              pinned: true,
              snap: false,
              floating: false,
              expandedHeight: 175,
              flexibleSpace: FlexibleSpaceBar(
                collapseMode: CollapseMode.pin,
                title: SearchFormField(
                  controller: searchController,
                  onchange: (v) {
                    if(v !=null  && v.isNotEmpty){
                      context.read<HomeController>().searchProduct(v);
                    }
                    else{
                      context.read<HomeController>().getProduct(isLimit: true);
                    }
                  },
                ),
                titlePadding:
                    const EdgeInsets.symmetric(horizontal: 28, vertical: 14),
                background: const MyAppBar(),
                expandedTitleScale: 1,
              ),
            ),
            const SliverToBoxAdapter(
              child: Body(),
            ),
          ],
        ),
      ),
    );
  }
}
