import 'package:almahbub_managment/application/app_controller.dart';
import 'package:almahbub_managment/presentation/utils/constants.dart';
import 'package:almahbub_managment/presentation/pages/chats/chats_page.dart';
import 'package:almahbub_managment/presentation/pages/favourite/favourite_screen.dart';
import 'package:almahbub_managment/presentation/pages/home_screen/home_page.dart';
import 'package:flutter/material.dart';
import 'package:proste_indexed_stack/proste_indexed_stack.dart';
import 'package:provider/provider.dart';
import 'package:rive/rive.dart';
import '../../../application/home_controller.dart';
import '../../utils/component/bottom_convex_bar.dart';
import '../add_screen/add_page.dart';
import '../category/category_screen.dart';
import 'menu.dart';

class MainPage extends StatefulWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage>
    with SingleTickerProviderStateMixin {
  int currentIndex = 0;
  bool isScroll = false;
  List<IndexedStackChild> listOfPage = [
    IndexedStackChild(child: const HomePage()),
    IndexedStackChild(child: const CategoryPage()),
    IndexedStackChild(child: const FavouritePage()),
    IndexedStackChild(child: const ChatsPage()),
    IndexedStackChild(child: const AddPage()),

  ];

  bool isSideBarOpen = false;

  Menu selectedSideMenu = sidebarMenus.first;

  late SMIBool isMenuOpenInput;

  late AnimationController _animationController;
  late Animation<double> scalAnimation;
  late Animation<double> animation;

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<HomeController>()
        ..getBanners()
        ..getProduct();
    });
    _animationController = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 200))
      ..addListener(
        () {
          setState(() {});
        },
      );
    scalAnimation = Tween<double>(begin: 1, end: 0.8).animate(CurvedAnimation(
        parent: _animationController, curve: Curves.fastOutSlowIn));
    animation = Tween<double>(begin: 0, end: 1).animate(CurvedAnimation(
        parent: _animationController, curve: Curves.fastOutSlowIn));
    super.initState();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      backgroundColor: kGreenColor,
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        bottom: false,
        child: ProsteIndexedStack(
          index: currentIndex,
          children: listOfPage,
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: BottomConvexBar(
        onChanged: (int value) {
          setState(() => currentIndex = value);
        },
        selectIndex: currentIndex,
        animValue: animation.value,
        isReverse: context.watch<AppController>().isReverse &&
            // ignore: unrelated_type_equality_checks
            ((bottomNavItems.length - 1) != currentIndex),
      ),
    );
  }
}
