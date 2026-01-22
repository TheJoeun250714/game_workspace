import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../../constants/game_assets.dart';

class GroundWidget extends StatelessWidget {
  const GroundWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Expanded(
        flex: 1,
        child: Container(
          decoration: const BoxDecoration(
              image: DecorationImage(
                  image: AssetImage(GameAssets.birdFluffyGround),
                  fit: BoxFit.cover
                //  fit: BoxFit.cover // cover 화면 전체 덮음
                //  fit: BoxFit.fill // fill 비율 무시하고 전체 차지
                //  fit: BoxFit.contain // contain 비율 유지하며 전체 보임

              )
          ),
        //    color:Colors.brown
        )
    );
  }
}
