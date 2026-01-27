import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../models/chat/chat_message.dart';

class ChatBubble extends StatelessWidget {
  final ChatMessage message;

  const ChatBubble({super.key, required this.message});

  @override
  Widget build(BuildContext context) {
    // 패딩으로 전체 설정 먼저할 것이다 = 맨 바깥에
    // Padding

    // 패딩보다 Row 로 먼저 작성한 다음에
    // 내부에서 padding 이라는 속성을 사용할 것이다.
    // 선택은 개발자의 자유
    return Padding(
        padding: const EdgeInsets.all(8),
        child: Row(
          mainAxisAlignment: message.isUser ? MainAxisAlignment.end : MainAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.all(12),
              child: Row(
                mainAxisAlignment: message.isUser? MainAxisAlignment.end: MainAxisAlignment.start,
                children: [
                  Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                        color: message.isUser? Colors.blue: Colors.grey[300],
                        borderRadius:
                        BorderRadius.circular(12)
                    ),
                    child: Text(
                      message.message,
                      style: TextStyle(
                          color: message.isUser? Colors.white: Colors.black),
                    ),
                  )
                ],
              ),
            )
          ],
        )
    );
  } // Widget build(BuildContext context) {
}   // class ChatBubble extends StatelessWidget {