import 'package:flutter/material.dart';
import 'package:focused_menu/focused_menu.dart';
import 'package:focused_menu/modals.dart';
class TapHolder extends StatelessWidget {
  final VoidCallback onEdit;
  final VoidCallback onDelete;
  final Widget child;
  const TapHolder({Key? key, required this.onEdit, required this.onDelete, required this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FocusedMenuHolder(
      blurSize: 10,
      duration: const Duration(milliseconds: 300),
      onPressed: () {},
      menuItems: [
        FocusedMenuItem(title: const Text("Edit"), onPressed: onEdit),
        FocusedMenuItem(title: const Text("Delete"), onPressed: onDelete),

      ],
      child: child,
    );
  }
}
