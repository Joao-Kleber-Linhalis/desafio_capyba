import 'dart:ui';

import 'package:desafio_capyba/shared/constants/collections.dart';
import 'package:desafio_capyba/shared/models/base_model.dart';
import 'package:flutter/material.dart';

class HomeModel extends BaseModel<HomeModel> {
  final String id;
  final String title;
  final String description;
  final String imageUrl;

  HomeModel({
    required this.id,
    required this.title,
    required this.description,
    required this.imageUrl,
  });

  factory HomeModel.empty() {
    return HomeModel(
      id: "",
      title: "",
      description: "",
      imageUrl: "",
    );
  }

  @override
  fromMap(Map<String, dynamic>? map) {
    if (map == null) return HomeModel.empty();
    return HomeModel(
      id: map["id"] ?? "",
      title: map['title'] ?? "",
      description: map['description'] ?? "",
      imageUrl: map['imageUrl'] ?? "",
    );
  }

  HomeModel copyWith({
    String? id,
    String? title,
    String? description,
    String? imageUrl,
  }) {
    return HomeModel(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      imageUrl: imageUrl ?? this.imageUrl,
    );
  }

  @override
  String get collection => Collections.home;

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
    };
  }

  @override
  Color get getColor => Colors.white;

  @override
  String get getDescription => description;

  @override
  String get getImageUrl => imageUrl;

  @override
  String get getRarity => "";

  @override
  String get getTitle => title;
}
