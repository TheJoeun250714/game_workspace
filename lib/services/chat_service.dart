import 'dart:convert';

import 'package:game_workspace/common/constants.dart';
import 'package:game_workspace/models/chat/chat_request.dart';
import 'package:game_workspace/models/chat/chat_response.dart';
import 'package:dio/dio.dart';
import 'package:http/http.dart' as http;
class ChatService {
  // Google Gemini API 설정
  static const String apiKey = "";
  static const String apiUrl = "https://generativelanguage.googleapis.com/v1beta/models/gemini-pro:generateContent";

  static Future<String> AIsendMessage(String message, List<Map<String, String>> conversationHistory) async {
    try{
      // 대화 히스토리를 Gemini API 형식으로 변환
    final List<Map<String, dynamic>> contents = [];

    // 이전 대화 추가
      for(var msg in conversationHistory) {
        contents.add({
          'role': msg['isUser'] == 'true' ? 'user' : 'model',
          'parts':[{'text':msg['message']}]
        });
      }
      // 현재 메세지
      contents.add({
        'role':'user',
        'parts':[{'text': message}]

      });

      final response = await http.post(
        Uri.parse('$apiUrl?key=$apiKey'),
        headers: {'Content-Type' : 'application/json'},
        body: jsonEncode({
          'contents': contents,
          'generationConfig':{
            'temperature':0.7,
            'maxOutputTokens':1000,
          }
        })
      );

      if(response.statusCode == 200) {
        final data = jsonDecode(response.body);
        return data['candidates'][0]['content']['parts'][0]['text'];
      } else {
        throw Exception('API 오류 : ${response.statusCode} - ${response.body}');
      }
    } catch (e) {
      throw Exception('메세지 전송 실패 : $e');
    }

  }

/*
백엔드 연결하여 챗봇 서비스 제공
  static final Dio _dio = Dio(
    BaseOptions(
      baseUrl: ApiConstants.baseUrl,
      connectTimeout: const Duration(seconds: 5),
      receiveTimeout: const Duration(seconds: 3),
      headers: {
        'Content-Type':'application/json'
      }
    )
  );


  static Future<ChatResponse> sendMessage(ChatRequest request) async {

      // dio post /message
      final res = await _dio.post("${ApiConstants.chatUrl}/message",
          data: request.toJson());

      return ChatResponse.fromJson(res.data);
    }

 */
}


