class ChatRequest {
  final String userId;
  final String message;
  final int? conversationId;

  ChatRequest(this.userId, this.message, [this.conversationId]);

  //  '문자열자료형'  T=Object 처럼 데이터 형태를 알 수 없기 때문에 null 까지 가능한
  //                           종합 자료형  형태로 처리

  Map<String         , dynamic> toJson() => {
    'userId':userId,
    'message':message,
    'conversationId':conversationId, //목록 형태

  };


}