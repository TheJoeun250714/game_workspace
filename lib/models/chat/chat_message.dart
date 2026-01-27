class ChatMessage {
  final String message;
  final bool isUser;
  final DateTime time;

  ChatMessage(this.message, this.isUser, this.time);


  // 순서에 개의치 않고, 키:변수이름 형태로 주고 받는 형식에서 주로 사용
  // 마치 json 이나 map 처럼
  //ChatMessage({this.message, this.isUser, this.time});
}