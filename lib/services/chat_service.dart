import 'package:game_workspace/common/constants.dart';
import 'package:game_workspace/models/chat/chat_request.dart';
import 'package:game_workspace/models/chat/chat_response.dart';
import 'package:dio/dio.dart';
import 'package:web/helpers.dart';
class ChatService {
  static const baseUrl = 'http://localhost:8080/api/chat';

  static final Dio _dio = Dio(
    BaseOptions(
      baseUrl: baseUrl,
      connectTimeout: const Duration(seconds: 5),
      receiveTimeout: const Duration(seconds: 3),
      headers: {
        'Content-Type':'application/json'
      }
    )
  );


  static Future<ChatResponse> sendMessage(ChatRequest request) async {

      // dio post /message
      final res = await _dio.post("${ApiConstants.baseUrl}/chat/message",
          data: request.toJson());

      return ChatResponse.fromJson(res.data);
    }
}