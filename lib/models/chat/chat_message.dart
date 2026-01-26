class ChatMessage {
  final String message;
  final bool isUser;
  final DateTime time;

  // 순서에 영향을 받고, 기본적으로 required 이기 때문에 required 생략 후, this 만 작성
  // (this.변수이름)
  // 현재 나의 클래스에 존재하는 기존 변수 명칭에 데이터 대입
  // (변수이름)
  // 현재 나의 클래스와는 별개로 외부에서 데이터를 받아오는 공간 명칭
  ChatMessage(this.message, this.isUser, this.time);
  // 순서에 개의치 않고, 키:변수이름 형태로 주고 받는 형식에서 주로 사용
  // 마치 json 이나 map 처럼
  //ChatMessage({this.message, this.isUser, this.time});
}