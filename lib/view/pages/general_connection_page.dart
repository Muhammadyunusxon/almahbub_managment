import 'package:almahbub_managment/constants.dart';
import 'package:almahbub_managment/view/pages/add_screen/add_screen.dart';
import 'package:almahbub_managment/view/pages/home_screen/home_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:proste_indexed_stack/proste_indexed_stack.dart';

import '../component/bottom_navy_bar.dart';
import '../style/style.dart';

class GeneralPage extends StatefulWidget {
  const GeneralPage({Key? key}) : super(key: key);

  @override
  State<GeneralPage> createState() => _GeneralPageState();
}

class _GeneralPageState extends State<GeneralPage> {
  int _currentIndex = 0;
  List<IndexedStackChild> listOfPage = [
    IndexedStackChild(child: const HomePage()),
    IndexedStackChild(child: const Placeholder()),
    IndexedStackChild(child: const Placeholder()),
    IndexedStackChild(child: const AddScreen())
  ];
  List<String> listOfBottom = [
    "home",
    "heart",
    "comment",
    "add",
  ];
  List<String> listOfName = [
    "Bosh sahifa",
    "Sevimlilar",
    "Chat",
    "Qo'shish",
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: ProsteIndexedStack(
        index: _currentIndex,
        children: listOfPage,
      ),
      floatingActionButtonLocation:
          FloatingActionButtonLocation.miniCenterFloat,
      floatingActionButton: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(24),
          child: BottomNavyBar(
            backgroundColor: Colors.white.withOpacity(0.99),
            selectedIndex: _currentIndex,
            showElevation: true,
            itemCornerRadius: 12,
            curve: Curves.easeInExpo,
            onItemSelected: (index) => setState(() => _currentIndex = index),
            items: [
              for (int i = 0; i < listOfBottom.length; i++)
                BottomNavyBarItem(
                  icon: SvgPicture.asset(
                    "assets/svg/${listOfBottom[i]}.svg",
                    color: kGreenColor,
                  ),
                  title: Text(
                    listOfName[i],
                    style: Style.bottomText(),
                  ),
                  activeColor: kGreenColor,
                ),
            ],
          ),
        ),
      ),
    );
  }
}
