import 'package:flutter/material.dart';
import 'package:game_workspace/models/chat/chat_message.dart';
import 'package:game_workspace/models/chat/chat_request.dart';
import 'package:game_workspace/services/chat_service.dart';
import 'package:game_workspace/widgets/chat/loading_indicator.dart';
import 'package:game_workspace/widgets/chat/message_input.dart';
import 'package:game_workspace/widgets/chat/message_list.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final TextEditingController controller = TextEditingController();
  List<ChatMessage> messages = [];
  bool loading = false;

//  int? conversationId;
//대화 히스토리 저장 (API 전송용)
  List<Map<String, String>> conversationHistory = [];

  void sendMessage() async {
    String text = controller.text;
    if (text.isEmpty) return;

    setState(() {
      messages.add(ChatMessage(text, true, DateTime.now()));
      loading = true;
    });

    controller.clear();

    try {
      // Gemini API 호출
      final response =
          await ChatService.AIsendMessage(text, conversationHistory);

      conversationHistory.add({'message': text, 'isUser': 'true'});
      conversationHistory.add({'message': response, 'isUser': 'false'});

      setState(() {
        messages.add(ChatMessage(response, false, DateTime.now()));
        loading = false;
      });
    } catch (e) {
      setState(() {
        loading = false;
      });
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('오류 : $e')));
    }
  }

/*
  void sendMessage() async {
    String text = controller.text;
    if (text.isEmpty) return;
    setState(() {
      messages.add(ChatMessage(text, true, DateTime.now()));
      loading = true;
    });
    controller.clear();
    try {
      final request = ChatRequest('user123', text, conversationId);
      final response = await ChatService.sendMessage(request);
      conversationId = response.conversationId;
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


 */
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('채팅'),
          backgroundColor: Colors.blue,
        ),
        body: Column(
          children: [
            // 메세지 리스트
            Expanded(
              child: MessageList(messages: messages),
            ),

            // 로딩 표시
            if (loading) const LoadingIndicator(),

            // 입력창
            MessageInput(
                controller: controller, onSend: sendMessage, isLoading: loading)
          ],
        ));
  }
}
