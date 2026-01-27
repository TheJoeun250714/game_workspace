/*
DIO 의 경우 각 서비스 환경마다
헤더를 다르게 줄 수 있는 경우가 있으므로
공통적으로 만들어 전체  서비스에서 사용하거나,
각 서비스에서 사용하는 dio 형태로 구분할 수 있다.
 */

class ApiConstants {
  static const String baseUrl='http://localhost:8080/api';
  static const String todosUrl='/todos';
  static const String chatUrl = '/chat';

}

class AppConstants {
  static const appName='My Todo List 2026';
  static const maxContentLength=255;
}
class ErrorMessages {
  static const networkError='네트워크 연결을 확인해주세요.';
  static const serverError='서버 오류가 발생했습니다.';
  static const loadFailed='Todo 목록을 불러오는데 실패했습니다.';
  static const createFailed='Todo 생성에 실패했습니다.';
  static const deleteFailed='Todo 삭제에 실패했습니다.';
  static const emptyContent='Todo 내용을 입력해주세요.';
}

class DialogMessages {
  static const deleteTitle='Todo 삭제';
  static const deleteContent='정말로 이 Todo를 삭제하시겠습니까?';
  static const cancel='취소';
  static const delete='삭제';
  static const add='추가';
}