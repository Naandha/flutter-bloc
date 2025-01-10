import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/chat_bloc.dart';
import '../bloc/chat_event.dart';
import '../bloc/chat_state.dart';

void main() {
  runApp(const Chat());
}

class Chat extends StatelessWidget {
  const Chat ({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: BlocProvider(
        create: (context) => ChatBloc(),
        child: const ChatScreen(),
      ),
    );
  }
}

class ChatScreen extends StatefulWidget {
  const ChatScreen({Key? key}) : super(key: key);

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final TextEditingController _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        leading: Padding(
          padding: const EdgeInsets.all(8.0),
          child: CircleAvatar(
            backgroundImage: NetworkImage(
                "https://play-lh.googleusercontent.com/LeX880ebGwSM8Ai_zukSE83vLsyUEUePcPVsMJr2p8H3TUYwNg-2J_dVMdaVhfv1cHg"),
          ),
        ),
        title: const Text(
          "danny hopkins",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.lightBlueAccent,

      ),
      body: Column(
        children: [
          Expanded(
            child: BlocBuilder<ChatBloc, ChatState>(
              builder: (context, state) {
                if (state is ChatUpdated) {
                  return ListView.builder(
                    reverse: true,
                    itemCount: state.messages.length,
                    itemBuilder: (context, index) {
                      final message =
                      state.messages[state.messages.length - index - 1];
                      return Align(
                        alignment: message.isSentByMe
                            ? Alignment.centerRight
                            : Alignment.centerLeft,
                        child: Container(
                          margin: const EdgeInsets.symmetric(
                              vertical: 5, horizontal: 10),
                          padding: const EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            color: message.isSentByMe
                                ? Colors.brown
                                : Colors.brown[300],
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Text(
                            message.text,
                            style: TextStyle(
                              color: message.isSentByMe
                                  ? Colors.green
                                  : Colors.black,
                            ),
                          ),
                        ),
                      );
                    },
                  );
                }
                return const Center(
                  child: Text(
                    "Start a conversation!",
                    style: TextStyle(color: Colors.green),
                  ),
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              style: const TextStyle(color: Colors.white),
              controller: _controller,
              decoration: InputDecoration(
                prefixIcon: IconButton(
                  icon: const Icon(Icons.camera_alt),
                  color: Colors.black,
                  onPressed: () {},
                ),
                hintText: "Type a message",
                hintStyle: const TextStyle(color: Colors.pink),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
                suffixIcon: Padding(
                  padding: const EdgeInsets.only(right: 4.0),
                  child: FloatingActionButton(
                    onPressed: () {
                      final message = _controller.text;
                      if (message.isNotEmpty) {
                        BlocProvider.of<ChatBloc>(context)
                            .add(SendMessage(message));
                        _controller.clear();
                      }
                    },
                    child: const Icon(Icons.send),
                    backgroundColor: Colors.white,
                    foregroundColor: Colors.black,
                    mini: true,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}