import 'package:flutter/cupertino.dart';
import 'package:game_workspace/models/clothing_item.dart';
import 'package:game_workspace/services/clothing_service.dart';

class DressUpProvider extends ChangeNotifier {
  int category = 0;
  List<ClothingItem?> equipped = [null, null, null, null, null];
  List<ClothingItem> get items {
    return ClothingService.items
        .where((item) =>item.type ==category)
        .toList();
  }

  void selectCategory(int type) {
    category = type;
    notifyListeners();
  }

  void selectItem(ClothingItem item) {
    equipped[item.type] = item;
    notifyListeners();
  }

  void removeItem() {
    equipped[category] = null;
    notifyListeners();
  }

  void reset() {
    equipped = [null, null, null, null, null];
    notifyListeners();
  }

  bool isEquipped(ClothingItem item) {
    return equipped[item.type]?.id == item.id;
  }
}
