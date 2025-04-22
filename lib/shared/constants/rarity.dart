import 'package:desafio_capyba/shared/constants/app_colors.dart';
import 'package:desafio_capyba/shared/constants/images_path.dart';
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
        return AppColors.commomColor;
      case 'Rare':
        return AppColors.rareColor;
      case 'Epic':
        return AppColors.epicColor;
      case 'Legendary':
        return AppColors.legendaryColor;
      default:
        return Colors.grey; // Para valores não reconhecidos
    }
  }

  static List<Color> rarityColors = [
    AppColors.commomColor,
    AppColors.rareColor,
    AppColors.epicColor,
    AppColors.legendaryColor,
  ];

  static String getStoneForRarity(String rarity) {
    switch (rarity) {
      case 'Common':
        return ImagesPath.commonStone;
      case 'Rare':
        return ImagesPath.rareStone;
      case 'Epic':
        return ImagesPath.epicStone;
      case 'Legendary':
        return ImagesPath.legendaryStone;
      default:
        return ImagesPath.commonStone;
    }
  }
}
