import 'package:almahbub_managment/application/app_controller.dart';
import 'package:almahbub_managment/presentation/utils/component/diss_keyboard.dart';
import 'package:almahbub_managment/presentation/utils/constants.dart';
import 'package:almahbub_managment/presentation/pages/home_screen/widget/app_bar.dart';
import 'package:almahbub_managment/presentation/pages/home_screen/widget/body.dart';
import 'package:almahbub_managment/presentation/utils/component/search_form_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:provider/provider.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import '../../../application/home_controller.dart';
import '../../../infrastructure/service/time_deleyed.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late TextEditingController searchController;
  late RefreshController _refreshController;
  ScrollController scrollController = ScrollController();

  final _delayed = Delayed(milliseconds: 700);

  @override
  void initState() {
    searchController = TextEditingController();
    _refreshController = RefreshController();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<HomeController>().getCategory();
    });

    super.initState();

    scrollController.addListener(() {
      final direction = scrollController.position.userScrollDirection;
      if (direction == ScrollDirection.reverse) {
        context.read<AppController>().changeReverse(true);
      } else if (direction == ScrollDirection.forward) {
        context.read<AppController>().changeReverse(false);
      }
    });
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
            controller: scrollController,
            physics: const BouncingScrollPhysics(),
            slivers: [
              SliverAppBar(
                backgroundColor: kGreenColor,
                toolbarHeight: 72,
                pinned: true,
                snap: false,
                floating: false,
                expandedHeight: 172,
                flexibleSpace: FlexibleSpaceBar(
                  collapseMode: CollapseMode.pin,
                  title: SearchFormField(
                    controller: searchController,
                    onchange: (v) {
                      _delayed.run(() async {
                        if (v != null && v.isNotEmpty) {
                          event.searchProduct(v);
                        } else {
                          event.getProduct();
                        }
                      });
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
