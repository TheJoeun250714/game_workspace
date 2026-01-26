import 'package:flutter/material.dart';
import 'package:game_workspace/models/chat/chat_message.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final TextEditingController controller = TextEditingController();
  List<ChatMessage> messages = [];
  bool loeading = false;
  int? conversationId;

  void sendMessage() async {

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('채팅'),
          backgroundColor: Colors.blue,
        ),
        body: Column(
          children: [
            Expanded(child: messages.isEmpty
                ?
            Center(child: Text('대화를 시작하세요'),)
                : ListView.builder(itemBuilder: (context, index) {
              final msg = messages[index];
              return Padding(
                padding: EdgeInsets.all(8),
                child: Row(
                  mainAxisAlignment: msg.isUser
                      ? MainAxisAlignment.end
                      : MainAxisAlignment.start,
                  children: [
                    Container(
                      padding: EdgeInsets.all(12),
                      child: Row(
                        mainAxisAlignment: msg.isUser
                            ? MainAxisAlignment.end
                            : MainAxisAlignment.start,
                        children: [
                          Container(
                            padding: EdgeInsets.all(12),
                            decoration: BoxDecoration(
                                color: msg.isUser ? Colors.blue : Colors
                                    .grey[300],
                                borderRadius: BorderRadius.circular(12)
                            ),
                            child: Text(msg.message, style: TextStyle(
                                color: msg.isUser ? Colors.white : Colors
                                    .black),),
                          )
                        ],
                      ),
                    )
                  ],
                ),
              );
            }))
          ],
        )
    );
  }
}
