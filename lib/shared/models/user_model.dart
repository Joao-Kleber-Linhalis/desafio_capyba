import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:desafio_capyba/shared/constants/collections.dart';
import 'package:desafio_capyba/shared/models/base_model.dart';

class UserModel extends BaseModel<UserModel> {
  final String id;
  final String name;
  final String photoUrl;
  final List<String> restrictedItems;
  final DateTime birthDate;

  UserModel({
    required this.id,
    required this.name,
    required this.photoUrl,
    required this.birthDate,
    required this.restrictedItems,
  });

  @override
  String get collection => Collections.users;

  bool get isEmpty => id.isEmpty || name.isEmpty || photoUrl.isEmpty;

  factory UserModel.empty() {
    return UserModel(
      id: "",
      name: "",
      photoUrl: "",
      birthDate: DateTime.now(),
      restrictedItems: [],
    );
  }

  UserModel copyWith({
    String? id,
    String? name,
    String? photoUrl,
    DateTime? birthDate,
    List<String>? restrictedItems,
  }) {
    return UserModel(
      id: id ?? this.id,
      name: name ?? this.name,
      photoUrl: photoUrl ?? this.photoUrl,
      birthDate: birthDate ?? this.birthDate,
      restrictedItems: restrictedItems ?? this.restrictedItems,
    );
  }

  @override
  UserModel fromMap(Map<String, dynamic>? map) {
    if (map == null) return UserModel.empty();
    return UserModel(
      id: map["id"] ?? "",
      name: map["name"] ?? "",
      photoUrl: map["photoUrl"] ?? "",
      birthDate: map['birthDate'] != null
          ? (map['birthDate'] as Timestamp).toDate()
          : DateTime.now(),
      restrictedItems: List<String>.from(map['restrictedItems'] ?? []),
    );
  }

  @override
  String get idModel => id;

  @override
  UserModel setIdModel(String id) {
    return copyWith(id: id);
  }

  @override
  Map<String, dynamic> toMap() {
    return {
      "id": id,
      "name": name,
      "photoUrl": photoUrl,
      "birthDate": Timestamp.fromDate(birthDate),
      "restrictedItems": restrictedItems,
    };
  }
}
