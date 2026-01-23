import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:game_workspace/constants/game_assets.dart';
import 'package:game_workspace/models/clothing_item.dart';

class ClothingService {
  static final List<ClothingItem> items = [
    ClothingItem('h1', '짧은머리', 0, GameAssets.dressUpHat1),
    ClothingItem('h2', '짧은머리', 0, GameAssets.dressUpHat1),
    ClothingItem('h3', '짧은머리', 0, GameAssets.dressUpHat1),
    ClothingItem('t1', '티셔츠', 1, GameAssets.dressUpClothes1),
    ClothingItem('t2', '티셔츠', 1, GameAssets.dressUpClothes1),
    ClothingItem('t3', '티셔츠', 1, GameAssets.dressUpClothes1),
    ClothingItem('b1', '바지', 2, GameAssets.dressUpClothes1),
    ClothingItem('b2', '바지', 2, GameAssets.dressUpClothes1),
    ClothingItem('s1', '신발', 3, GameAssets.dressUpShoes1),
    ClothingItem('a1', '가방', 4, GameAssets.dressUpAcc1),
    ClothingItem('a2', '무기', 4, GameAssets.dressUpAcc1),
  ];
}

