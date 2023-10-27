class ChatModel {
  final String id;
  final String name;
  final String? text;
  final String? time;
  final String? avatarImage;

  ChatModel(
      {required this.id,
      required this.name,
      this.text,
      this.time,
      this.avatarImage});
}
