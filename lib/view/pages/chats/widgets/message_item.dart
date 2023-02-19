import 'package:flutter/material.dart';
import 'package:focused_menu/focused_menu.dart';
import 'package:focused_menu/modals.dart';
import 'package:intl/intl.dart';

import '../../../../domen/model/message_model.dart';

class MessageItem extends StatelessWidget {
  final bool isOwner;
  final VoidCallback onEdit;
  final VoidCallback onDelete;
  final MessageModel message;

  const MessageItem(
      {Key? key,
      required this.isOwner,
      required this.onEdit,
      required this.onDelete,
      required this.message})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FocusedMenuHolder(
      blurSize: 10,
      duration: const Duration(milliseconds: 300),
      onPressed: () {},
      menuItems: isOwner
          ? [
              FocusedMenuItem(title: const Text("Edit"), onPressed: onEdit),
              FocusedMenuItem(title: const Text("Delete"), onPressed: onDelete),
            ]
          : [
              FocusedMenuItem(title: const Text("Delete"), onPressed: onDelete),
            ],
      child: Container(
        margin: const EdgeInsets.only(bottom: 12),
        decoration: BoxDecoration(
          color: isOwner ? Colors.pinkAccent : Colors.grey,
          borderRadius: BorderRadius.circular(24),
        ),
        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 20),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Text(
              message.title,
              style: TextStyle(
                  color: isOwner
                      ? Colors.white
                      : Colors.black),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 8, left: 4),
              child: Text(
                DateFormat("hh:mm").format(message.time),
                style: TextStyle(
                    color: isOwner
                        ? Colors.white
                        : Colors.black,
                    fontSize: 10),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
