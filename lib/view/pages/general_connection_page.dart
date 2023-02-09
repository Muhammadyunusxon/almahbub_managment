import 'package:almahbub_managment/constants.dart';
import 'package:almahbub_managment/view/pages/add_screen/add_screen.dart';
import 'package:almahbub_managment/view/pages/chats/chats_page.dart';
import 'package:almahbub_managment/view/pages/favourite/favourite_screen.dart';
import 'package:almahbub_managment/view/pages/home_screen/home_page.dart';
import 'package:diamond_bottom_bar/diamond_bottom_bar.dart';
import 'package:flutter/material.dart';
import 'package:proste_indexed_stack/proste_indexed_stack.dart';
import 'category/category_screen.dart';

class GeneralPage extends StatefulWidget {
  const GeneralPage({Key? key}) : super(key: key);

  @override
  State<GeneralPage> createState() => _GeneralPageState();
}

class _GeneralPageState extends State<GeneralPage> {
  int _currentIndex = 0;
  List<IndexedStackChild> listOfPage = [
    IndexedStackChild(child: const HomePage()),
    IndexedStackChild(child: const CategoryScreen()),
    IndexedStackChild(child: const AddScreen()),
    IndexedStackChild(child: const ChatsPage()),
    IndexedStackChild(child: const FavouriteScreen()),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kGreenColor,
      resizeToAvoidBottomInset: false,
      extendBody: true,
      body: SafeArea(
        bottom:false,
        child: ProsteIndexedStack(
          index: _currentIndex,
          children: listOfPage,
        ),
      ),
   bottomNavigationBar: DiamondBottomNavigation(
       selectedColor:kGreenColor,
     itemIcons: const [
       Icons.home,
       Icons.category,
       Icons.message,
       Icons.favorite,
     ],
     centerIcon: Icons.add,
     selectedIndex: _currentIndex,
     onItemPressed: (s){
       _currentIndex=s;
       setState(() {});
     },
   ),
    );
  }
}
