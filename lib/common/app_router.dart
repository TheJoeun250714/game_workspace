import 'package:game_workspace/models/game_item.dart';
import 'package:game_workspace/screens/bird_fluffy_screen.dart';
import 'package:game_workspace/screens/main_screen.dart';
import 'package:go_router/go_router.dart';

class AppRouter {
  static final router = GoRouter(
      initialLocation: '/',

      routes: [
        GoRoute(path: '/',builder: (context,state) => MainScreen()
        ),
        GoRoute(path: '/game/:id',
        builder: (context,state) {
          final id = state.pathParameters['id']!;
          final game = state.extra as GameItem?;
          // 매개변수 생성자로 gameId 를 담아갈 변수명칭과
          // gameItem 담아갈 변수명칭을
          // 반드시 GameScreen 내부에 생성!
          return BirdFluffyScreen(gameId: id, gameItem:game);
        }
        )
      ]);
}