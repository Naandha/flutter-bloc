import 'package:flutter_bloc/flutter_bloc.dart';
import 'chat_event.dart';
import 'chat_state.dart';

class ChatBloc extends Bloc<ChatEvent, ChatState> {
  ChatBloc() : super(ChatUpdated([])) {
    on<SendMessage>((event, emit) {
      if (state is ChatUpdated) {
        final currentState = state as ChatUpdated;
        final List<ChatMessage> updatedMessages =
        List<ChatMessage>.from(currentState.messages)
          ..add(ChatMessage(event.message, isSentByMe: true));
        updatedMessages.add(ChatMessage("Hi", isSentByMe: false));
        emit(ChatUpdated(updatedMessages));
      }
    });
  }
}