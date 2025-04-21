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
        return Colors.white;
      case 'Rare':
        return Colors.blue;
      case 'Epic':
        return Colors.purple;
      case 'Legendary':
        return Colors.orange;
      default:
        return Colors.grey; // Para valores não reconhecidos
    }
  }
}
