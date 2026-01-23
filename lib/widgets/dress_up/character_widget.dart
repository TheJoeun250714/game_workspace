import 'package:flutter/material.dart';
import 'package:game_workspace/constants/game_assets.dart';
import 'package:game_workspace/models/clothing_item.dart';

class CharacterWidget extends StatelessWidget {
  final List<ClothingItem?> equipped;

  const CharacterWidget({super.key, required this.equipped});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 400,
      height: 400,
      decoration: BoxDecoration(
          color: Colors.white, borderRadius: BorderRadius.circular(20)),
      child: Stack(
        children: [
          _buildBody(),
          //_buildHead(),
          if (equipped[0] != null) _buildHair(),
          if (equipped[1] != null) _buildTop(),
        //  if (equipped[2] != null) _buildBottom(),
          if (equipped[3] != null) _buildShoes(),
          if (equipped[4] != null) _buildAcc(),
        ],
      ),
    );
  }

  // 옷입히기나 캐릭터 세팅의 경우 포지션으로 위치를 명확하게 잡아주어야 함

  // 몸통
  Widget _buildBody() {
    return Positioned(
        child: Image.asset(
      GameAssets.dressUpBody,
      width: 400,
      height: 400,
      fit: BoxFit.contain,
    ));
  }

  // 머리
  Widget _buildHead() {
    return Positioned(
        child: Container(
      width: 400,
      height: 400,
      decoration:
          const BoxDecoration(color: Color(0xFFFFDBAC), shape: BoxShape.circle),
    ));
  }

  // 헤어
  Widget _buildHair() {
    return Positioned(
      child: Image.asset(
        equipped[0]!.imageAsset,
        width: 400,
        height: 400,
        fit: BoxFit.contain,
      ),
    );
  }

  // 상의
  Widget _buildTop() {
    return Positioned(
        child: Image.asset(
      equipped[1]!.imageAsset,
      width: 400,
      height: 400,
      fit: BoxFit.contain,
    ));
  }

  // 하의
  /*
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

   */
  // 신발
  Widget _buildShoes() {
    return Positioned(
        child: Image.asset(
          equipped[3]!.imageAsset,
          width: 400,
          height: 400,
          fit: BoxFit.contain,
        ));
  }

  // 악세사리
  Widget _buildAcc() {
    return Positioned(
        child: Image.asset(
          equipped[4]!.imageAsset,
          width: 400,
          height: 400,
          fit: BoxFit.contain,
        ));
  }
}

/*
하의 -> 무기(weapon) 로 교체

악세사리에는 가방

선택된 아이템을 한 번 더 클릭하면 아이템 장착 해제

배경 카테고리 추가 후 배경 교체
Icons.do_not_disturb 선택시 배경 없애기
 */