class MessageModel {
  final String title;
  final DateTime time;
  final String ownerId;
  final String messId;
  final String? type;

  MessageModel({
    required this.title,
    required this.time,
    required this.ownerId,
    required this.messId,
    required this.type,
  });

  factory MessageModel.fromJson({required Map data, required String messId}) {
    return MessageModel(
      title: data["title"],
      time: DateTime.parse(data["time"]),
      ownerId: data["ownerId"],
      messId: messId,
      type: data["type"] ?? "text",
    );
  }

  toJson() {
    return {
      "title": title,
      "time": time.toString(),
      "ownerId": ownerId,
      "type": type
    };
  }
}
