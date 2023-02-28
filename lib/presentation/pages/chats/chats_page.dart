import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../application/chat_controller.dart';
import '../../utils/Style/style.dart';
import '../../utils/component/custom_text_from.dart';
import '../../utils/constants.dart';
import 'message_page.dart';

class ChatsPage extends StatefulWidget {
  const ChatsPage({Key? key}) : super(key: key);

  @override
  State<ChatsPage> createState() => _ChatsPageState();
}

class _ChatsPageState extends State<ChatsPage> {
  final TextEditingController searchUser = TextEditingController();

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<ChatController>()
        ..getUserList()
        ..getChatsList();
    });
    super.initState();
  }

  @override
  void dispose() {
    context.read<ChatController>().setOffline();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final event = context.read<ChatController>();
    final state = context.watch<ChatController>();
    return Scaffold(
      appBar: AppBar(
        backgroundColor: kGreenColor,
        title: Text(
          "Chatlar",
          style: Style.brandStyle(size: 20, textColor: kWhiteColor),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          children: [
            Row(
              children: [
                Expanded(
                    child:
                        CustomTextFrom(controller: searchUser, label: "Users")),
                IconButton(
                    onPressed: () {
                      event.changeAddUser();
                    },
                    icon: !state.addUser
                        ? const Icon(Icons.add)
                        : const Icon(Icons.backspace))
              ],
            ),
            state.addUser
                ? Expanded(
                    child: ListView.builder(
                        shrinkWrap: true,
                        itemCount: state.users.length,
                        itemBuilder: (context, index) {
                          return InkWell(
                            onTap: () {
                              event.createChat(index, (id) {
                                Navigator.of(context).push(MaterialPageRoute(
                                    builder: (_) => MessagePage(
                                          docId: id,
                                          user: state.users[index],
                                        )));
                              });
                            },
                            child: Container(
                              margin: const EdgeInsets.all(24),
                              child: Row(
                                children: [
                                  state.users[index].avatar == null
                                      ? const SizedBox.shrink()
                                      : ClipOval(
                                          child: Image.network(
                                            state.users[index].avatar ?? "",
                                            height: 62,
                                            width: 62,
                                          ),
                                        ),
                                  Text(state.users[index].name ?? "")
                                ],
                              ),
                            ),
                          );
                        }),
                  )
                : Expanded(
                    child: ListView.builder(
                        shrinkWrap: true,
                        itemCount: state.chats.length,
                        itemBuilder: (context, index) {
                          return InkWell(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (_) => MessagePage(
                                            docId:
                                                state.listOfDocIdChats[index],
                                            user: state.chats[index].reSender,
                                          )));
                            },
                            child: Container(
                              color: Colors.pinkAccent,
                              margin: const EdgeInsets.all(24),
                              child: Row(
                                children: [
                                  state.chats[index].reSender.avatar == null
                                      ? const SizedBox.shrink()
                                      : ClipOval(
                                          child: Image.network(
                                            state.chats[index].reSender
                                                    .avatar ??
                                                "",
                                            height: 62,
                                            width: 62,
                                          ),
                                        ),
                                  const Spacer(),
                                  Column(
                                    children: [
                                      Text(state.chats[index].reSender.name ??
                                          ""),
                                      Text(state.chats[index].userStatus
                                          .toString()),
                                    ],
                                  )
                                ],
                              ),
                            ),
                          );
                        }),
                  )
          ],
        ),
      ),
    );
  }
}
