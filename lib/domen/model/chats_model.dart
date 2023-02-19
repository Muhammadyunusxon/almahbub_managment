
import 'package:almahbub_managment/domen/model/user_model.dart';

class ChatsModel {
  final List ids;
  final UserModel sender;
  final bool userStatus;
  final UserModel reSender;

  ChatsModel({
    required this.userStatus,
    required this.ids,
    required this.sender,
    required this.reSender,
  });

  factory ChatsModel.fromJson({
    required Map data,
    Map<String, dynamic>? sender,
    Map<String, dynamic>? reSender,
    required bool isOnline,
  }) {
    return ChatsModel(
      ids: data["ids"],
      sender: UserModel.fromJson(sender),
      reSender: UserModel.fromJson(reSender),
      userStatus: isOnline,
    );
  }
}
