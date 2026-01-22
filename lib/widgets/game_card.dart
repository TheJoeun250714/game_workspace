import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:game_workspace/models/game_item.dart';
import 'package:go_router/go_router.dart';

class GameCard extends StatelessWidget {
  final GameItem game;

  const GameCard({super.key, required this.game});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => context.push('/game/${game.id}', extra: game),
      child: Container(
        decoration: BoxDecoration(
          color: game.color,
          borderRadius: BorderRadius.circular(20),
          // 힌트: BoxShadow 사용 (색상: Colors.black26, blurRadius: 10, offset: Offset(0, 5))
          /*
          boxShadow 내부에 어떠한 값을 넣어야 할지 모를 경우
          속성 위에 마우스를 살짝 올려보기
           대부분의 클래스는  {List<BoxShadow>? boxShadow} 타입: List<BoxShadow>?
           타입이 List 형태로 되어있다면 [] 형태 사용
           boxShadow: [],
           */
          boxShadow: const [
            BoxShadow(
                color: Colors.black26, blurRadius: 10, offset: Offset(0, 5))
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(height: 5),
            if (game.imageAsset != null)
              Image.asset(
                game.imageAsset!,
                width: 50,
                height: 50,
                fit: BoxFit.contain,
              ),
            if (game.icon != null)
              Icon(game.icon, size: 64, color: Colors.white),
            const SizedBox(height: 16),
            Text(
              game.name,
              style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.white),
            )
          ],
        ),
      ),
    );
  }
}
