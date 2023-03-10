import 'package:almahbub_managment/presentation/utils/component/diss_keyboard.dart';
import 'package:almahbub_managment/presentation/utils/constants.dart';
import 'package:almahbub_managment/presentation/pages/home_screen/widget/app_bar.dart';
import 'package:almahbub_managment/presentation/pages/home_screen/widget/body.dart';
import 'package:almahbub_managment/presentation/utils/component/search_form_field.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import '../../../application/home_controller.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late TextEditingController searchController;
  late RefreshController _refreshController;

  @override
  void initState() {
    searchController = TextEditingController();
    _refreshController = RefreshController();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<HomeController>().getCategory();
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
    var event = context.read<HomeController>();
    return OnUnFocusTap(
      child: Scaffold(
        backgroundColor: kBGColor,
        body: SmartRefresher(
          controller: _refreshController,
          enablePullDown: true,
          enablePullUp: true,
          onLoading: () async {
            await event.getPageProduct(_refreshController);
          },
          onRefresh: () async {
            event.getPageProduct(_refreshController);
            _refreshController.refreshCompleted();
          },
          child: CustomScrollView(
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
                      if (v != null && v.isNotEmpty) {
                        event.searchProduct(v);
                      } else {
                        event.getProduct(isLimit: true);
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
      ),
    );
  }
}
