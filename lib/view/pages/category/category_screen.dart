import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../controller/home_controller.dart';
import '../../component/custom_text_from.dart';

class CategoryScreen extends StatefulWidget {
  const CategoryScreen({Key? key}) : super(key: key);

  @override
  State<CategoryScreen> createState() => _CategoryScreenState();
}

class _CategoryScreenState extends State<CategoryScreen> {
  final TextEditingController search = TextEditingController();

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<HomeController>().getCategory(isLimit: false);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final state = context.watch<HomeController>();
    final event = context.read<HomeController>();
    return Scaffold(
      appBar: AppBar(
        title: Text("Category"),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: CustomTextFrom(
              controller: search,
              label: "Search",
              onChange: (s) {
                event.searchCategory(s);
              },
            ),
          ),
          Expanded(
            child: GridView.builder(
                shrinkWrap: true,
                itemCount: state.listOfCategory.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                ),
                itemBuilder: (context, index) {
                  return Container(
                    margin: const EdgeInsets.all(8),
                    width: 100,
                    height: 100,
                    color: Colors.pinkAccent,
                    child: Column(
                      children: [
                        state.listOfCategory[index].image == null
                            ? const SizedBox.shrink()
                            : Image.network(
                          state.listOfCategory[index].image ?? "",
                          height: 80,
                          width: 80,
                        ),
                        Text(state.listOfCategory[index].name ?? "")
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