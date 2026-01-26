import 'package:flutter/material.dart';
import 'package:game_workspace/models/chat/chat_message.dart';
import 'package:game_workspace/models/chat/chat_request.dart';
import 'package:game_workspace/services/chat_service.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final TextEditingController controller = TextEditingController();
  List<ChatMessage> messages = [];
  bool loading = false;
  int? conversationId;

  void sendMessage() async {
    String text = controller.text;
    if (text.isEmpty) return;

    // 내 메세지 추가
    setState(() {
      messages.add(ChatMessage(text, true, DateTime.now()));
      loading = true;
    });
    controller.clear();

    // 서버에 보내기
    try {
      final request = ChatRequest('user123', text, conversationId);
      final response = await ChatService.sendMessage(request);

      conversationId = response.conversationId;

      // 챗봇 답변 추가
      setState(() {
        messages.add(ChatMessage(response.message, false, DateTime.now()));
        loading = false;
      });
    } catch (e) {
      setState(() {
        loading = false;
      });
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('오류: $e')));
    }
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
            Expanded(
                child: messages.isEmpty
                    ? const Center(
                        child: Text('대화를 시작하세요'),
                      )
                    : ListView.builder(
                    itemCount: messages.length,
                    itemBuilder: (context, index) {
                        final msg = messages[index];
                        return Padding(
                          padding: const EdgeInsets.all(8),
                          child: Row(
                            mainAxisAlignment: msg.isUser
                                ? MainAxisAlignment.end
                                : MainAxisAlignment.start,
                            children: [
                              Container(
                                padding: const EdgeInsets.all(12),
                                child: Row(
                                  mainAxisAlignment: msg.isUser
                                      ? MainAxisAlignment.end
                                      : MainAxisAlignment.start,
                                  children: [
                                    Container(
                                      padding: const EdgeInsets.all(12),
                                      decoration: BoxDecoration(
                                          color: msg.isUser
                                              ? Colors.blue
                                              : Colors.grey[300],
                                          borderRadius:
                                              BorderRadius.circular(12)),
                                      child: Text(
                                        msg.message,
                                        style: TextStyle(
                                            color: msg.isUser
                                                ? Colors.white
                                                : Colors.black),
                                      ),
                                    )
                                  ],
                                ),
                              )
                            ],
                          ),
                        );
                      })),
            if (loading)
              const Padding(
                padding: EdgeInsets.all(8),
                child: Text("생각중..."),
              ),
            // 입력 창
            Padding(
              padding: const EdgeInsets.all(8),
              child: Row(
                children: [
                  Expanded(
                      child: TextField(
                          controller: controller,
                          decoration: const InputDecoration(
                            hintText: '메세지 입력',
                            border: OutlineInputBorder(),
                          ),
                          onSubmitted: (_) => sendMessage()))
                ],
              ),
            )
          ],
        ));
  }
}
