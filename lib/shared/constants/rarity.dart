import 'package:flutter/material.dart';

class Rarity {
  static const List<String> rarities = [
    "Common",
    "Rare",
    "Epic",
    "Legendary",
  ];

  static Color getColorForRarity(String rarity) {
    switch (rarity) {
      case 'Common':
        return Color(0xffCDD7CC);
      case 'Rare':
        return Color(0xff419EFD);
      case 'Epic':
        return Color(0xffDF58F7);
      case 'Legendary':
        return Color(0xffFFA50D);
      default:
        return Colors.grey; // Para valores não reconhecidos
    }
  }
}
