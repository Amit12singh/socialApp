class ChatModel {
  final String id;
  final String name;
  final String text;
  final String time;
  final String? avatarImage;

  ChatModel(
      {required this.id,
      required this.name,
      required this.text,
      required this.time,
      this.avatarImage});
}
