import 'dart:convert';
// json 인코딩 디코딩 기능 제공
// -> 주소로 데이터 주고받을 때 문자열로 변환
// 데이터 가져와서 활용할 때 문자열을 json 형태로 변환 처리

// 아래는 자바 백엔드에서 사용하는 모델
import 'package:game_workspace/common/constants.dart';          // API URL 등 상수를 정의한 파일
import 'package:game_workspace/models/chat/chat_request.dart';  // 채팅 요청 보내는 모델
import 'package:game_workspace/models/chat/chat_response.dart'; // 채팅 요청에 따른 응답을 받아오는 모델
import 'package:dio/dio.dart';
import 'package:http/http.dart' as http;                        // http 내용 자체를 http 라는 별칭으로 사용
class ChatService {
  // Google Gemini API 설정

  // static 으로 지정하는 상수는 클래스 레벨의 상수로 인스턴스 생성없이 사용 가능
  // 객체를 만들지않고, 모두가 apiKey 사용할 수 있음 / 비공개 처리가 아니기 때문에 어디서든지 접근 가능
  static const String apiKey = "        ";
  // gemini API 사용할 모델 이름                                                         모델명   : 콘텐츠생성으로 사용
  // static const String apiUrl = "https://generativelanguage.googleapis.com/v1beta/models/gemini-pro:generateContent";
  // static const String apiUrl = "https://generativelanguage.googleapis.com/v1/models/gemini-1.5-flash:generateContent";
  static const String apiUrl = "https://generativelanguage.googleapis.com/v1beta/models/gemini-2.5-flash:generateContent";

  //     비동기 함수 미래에 String 결과 반환
  //                                      메세지       키 데이터 형태의 목록들   이전 대화 내역 리스트
  //                                                    [{chatbot : 대화} , {user:대화}]
  static Future<String> AIsendMessage(String message, List<Map<String, String>> conversationHistory) async {
    try{
      // 대화 히스토리를 Gemini API 형식으로 변환
    final List<Map<String, dynamic>> contents = []; // Gemini API에 보낼 대화 내용을 저장할 빈 리스트

    // 이전 대화 추가
    /*
    'role' : Map의 키 - role 이라는 이름
    msg['isUser'] == 'true' - 조건 확인 - msg 라는 Map 에서 'isUser'값이 'true'인지 비교
    msg는 {'message':'안녕','isUser':'true'} 같은 형태
     */
      for(var msg in conversationHistory) {
        contents.add({
          // 사용자 메세지일 때 true role : user
          // A    I 메세지 일 때 false role : model
          'role': msg['isUser'] == 'true' ? 'user' : 'model',
          'parts':[{'text':msg['message']}]
        });
      }
      /*
      === gemini 형식 ====
      contents =[
            {
            'role':'user'
            'parts' : [{'text':'안녕'}]
            },
            {
            'role':'model'
            'parts' : [{'text':'안녕하세요'}]
            }
      ]
      // chat_screen 에서 사용하는 대화 히스토리 방식
     conversationHistory = [
       {'message':'안녕', 'isUser' : 'true'},
       {'message':'안녕하세요', 'isUser' : 'false'},

     ]
       */
      // 현재 메세지
      contents.add({
        'role':'user',
        'parts':[{'text': message}]

      });

      final response = await http.post(
        Uri.parse('$apiUrl?key=$apiKey'),   // ApI가 요구하는 키
        headers: {'Content-Type' : 'application/json'},
        body: jsonEncode({            // dart 형식으로 작성한 데이터를 json 문자열형태로 변환 하겠다.
          'contents': contents,      // contents - 위에서 만든 대화 내역 리스트
          'generationConfig':{       // AI 생성 설정 객체
            'temperature':0.7,       // 응답의 창의성 / 무작위성 조절 0.7 중간 정보 (0.0 = 보수적, 1.0 = 창의적)
            'maxOutputTokens':1000, // 최대 응답 길이 약 750 단어 토큰 = 0.75 단어
          }
        })
      );

      if(response.statusCode == 200) {
        final data = jsonDecode(response.body);
        /*
        data['candidates'] = API 응답 후보들의 배열 에서
                 [0]       = 첫 번째 후보 선택
               ['content'] = 컨텐츠 객체
               ['parts']   = 컨텐츠들 중에서
                 [0]       = 첫 번째로 존재하는 컨텐츠의
                ['text']   = 실제 텍스트 내용을 반환하겠다.
         */
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


