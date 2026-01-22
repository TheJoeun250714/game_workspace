import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:game_workspace/constants/game_assets.dart';
import 'package:provider/provider.dart';

import '../../providers/game_provider.dart';

class BirdWidget extends StatelessWidget {
  const BirdWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final game = context.watch<GameProvider>(); //게임상태 확인
    final birdY = game.birdY;

    return AnimatedContainer(
      duration: const Duration(milliseconds: 0),
      alignment: Alignment(0, birdY),
      child: Container(
        // 게임 시작하고 나면 사이즈 50 정도로 맞추고 게임 로딩중 gif 상대적으로 사이즈가 작기 때문에 사이즈 키움
        width: game.gameStarted ? 50 : 200,
        /* 새 모형의 크기 정사각형 */
        height: game.gameStarted ? 50 : 200,
        decoration: BoxDecoration(
            image: DecorationImage(
                // 게임 시작 전에는 gif 시작 후에는 png
                image: AssetImage(game.gameStarted
                    ?GameAssets.birdFluffyFlyBird
                    :GameAssets.birdFluffyLoading),
                fit: BoxFit.contain, // cover = 50 50 맞추기 contain = 비율 유지
                filterQuality: FilterQuality.none // 픽셀아트의 경우 이 옵션을 추가하면 더 선명
                )),

        // decoration: const BoxDecoration(
        //   color: Colors.yellow,
        //   shape: BoxShape.circle,
        // ),
        //child: const Center(
        // child: Text('🐌', style: TextStyle(fontSize: 30),),

        // ),
      ),
    );
  }
}
