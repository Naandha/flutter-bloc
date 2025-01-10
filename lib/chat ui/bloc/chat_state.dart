abstract class ChatState {}
class ChatInitial extends ChatState {}
class ChatUpdated extends ChatState {
  final List<ChatMessage> messages;
  ChatUpdated(this.messages);
}
class ChatMessage {
  final String text;
  final bool isSentByMe;
  ChatMessage(this.text, {required this.isSentByMe});
}