import 'dart:ui';

import 'package:flutter/cupertino.dart';

class GameItem {
  final String id;
  final String name;
  final Color color;
  final IconData? icon;
  final String? imageAsset;

  GameItem(
      {required this.id,
      required this.name,
      required this.color,
      this.icon,
      this.imageAsset
      });
}

