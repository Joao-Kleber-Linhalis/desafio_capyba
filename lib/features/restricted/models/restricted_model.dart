import 'dart:ui';

import 'package:desafio_capyba/shared/constants/collections.dart';
import 'package:desafio_capyba/shared/constants/rarity.dart';
import 'package:desafio_capyba/shared/models/base_model.dart';

class RestrictedModel extends BaseModel<RestrictedModel> {
  final String id;
  final String title;
  final String description;
  final String rarity;
  final String imageUrl;

  RestrictedModel({
    required this.rarity,
    required this.id,
    required this.title,
    required this.description,
    required this.imageUrl,
  });

  factory RestrictedModel.empty() {
    return RestrictedModel(
      rarity: "",
      id: "",
      title: "",
      description: "",
      imageUrl: "",
    );
  }

  @override
  fromMap(Map<String, dynamic>? map) {
    if (map == null) return RestrictedModel.empty();
    return RestrictedModel(
      rarity: map["rarity"] ?? "",
      id: map["id"] ?? "",
      title: map['title'] ?? "",
      description: map['description'] ?? "",
      imageUrl: map['imageUrl'] ?? "",
    );
  }

  RestrictedModel copyWith({
    String? id,
    String? title,
    String? description,
    String? imageUrl,
    String? rarity,
  }) {
    return RestrictedModel(
      rarity: rarity ?? this.rarity,
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      imageUrl: imageUrl ?? this.imageUrl,
    );
  }

  @override
  String get collection => Collections.restricted;

  @override
  String get idModel => id;

  @override
  setIdModel(String id) {
    return copyWith(id: id);
  }

  @override
  Map<String, dynamic> toMap() {
    return {
      "id": id,
      "title": title,
      "description": description,
      "imageUrl": imageUrl,
      "rarity": rarity,
    };
  }

  @override
  Color get getColor => Rarity.getColorForRarity(rarity);

  @override
  String get getDescription => description;

  @override
  String get getImageUrl => imageUrl;

  @override
  String get getRarity => rarity;

  @override
  String get getTitle => title;
}
