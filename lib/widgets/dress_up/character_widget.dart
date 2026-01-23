import 'package:flutter/material.dart';
import 'package:game_workspace/constants/game_assets.dart';
import 'package:game_workspace/models/clothing_item.dart';

class CharacterWidget extends StatelessWidget {
  final List<ClothingItem?> equipped;

  const CharacterWidget({super.key, required this.equipped});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 200,
      height: 400,
      decoration: BoxDecoration(
          color: Colors.white, borderRadius: BorderRadius.circular(20)),
      child: Stack(
        children: [
          // 몸통
          _buildBody(),

          // 머리
          //_buildHead(),
          // 헤어 (장착시)
          if (equipped[0] != null) _buildHair(),
          // 상의 (장착시)
          if (equipped[1] != null) _buildTop(),

          // 하의 (장착시)
          if (equipped[2] != null) _buildBottom(),

          // 신발 (장착시)
          if (equipped[3] != null) _buildShoes(),

          // 악세사리 (장착시)
          if (equipped[4] != null) _buildAcc(),
        ],
      ),
    );
  }

  // 옷입히기나 캐릭터 세팅의 경우 포지션으로 위치를 명확하게 잡아주어야 함

  // 몸통
  Widget _buildBody() {
    return Positioned(
        bottom: 100,
        left: 60,
        child: Image.asset(
          GameAssets.dressUpBody,
          width: 150,
          height: 150,
          fit: BoxFit.cover,
        ));
  }

  // 머리
  Widget _buildHead() {
    return Positioned(
        top: 40,
        left: 50,
        child: Container(
          width: 100,
          height: 100,
          decoration: const BoxDecoration(
              color: Color(0xFFFFDBAC), shape: BoxShape.circle),
        ));
  }

  // 헤어
  Widget _buildHair() {
    return Positioned(
      top: 30,
      left: 45,
      child: Image.asset(
        equipped[0]!.imageAsset,
        width: 110,
        height: 80,
        fit: BoxFit.cover,
      ),
    );
  }

  // 상의
  Widget _buildTop() {
    return Positioned(
        top: 140,
        left: 55,
        child: Image.asset(
          equipped[1]!.imageAsset,
          width: 110,
          height: 80,
          fit: BoxFit.cover,
        ));
  }
  // 하의
  Widget _buildBottom() {
    return Positioned(
        top: 210,
        left: 55,
        child: Image.asset(
          equipped[2]!.imageAsset,
          width: 90,
          height: 80,
          fit: BoxFit.cover,
        ));
  }
  // 신발
  Widget _buildShoes() {
    return Positioned(
        bottom: 70,
        left: 55,
        child: Image.asset(
          equipped[2]!.imageAsset,
          width: 90,
          height: 30,
          fit: BoxFit.cover,
        ));
  }
  // 악세사리
  Widget _buildAcc() {
    return Positioned(
        top: 140,
        left: 55,
        child: Image.asset(
          equipped[4]!.imageAsset,
          width: 30,
          height: 30,
          fit: BoxFit.cover,
        ));
  }
}
