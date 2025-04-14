import 'package:desafio_capyba/core/services/firebase_service.dart';

abstract class BaseModel {
  String get id;
  String get collection;
  BaseModel empty();
  BaseModel fromMap(Map<String, dynamic>? map);
  Map<String, dynamic> toMap();
  BaseModel setid(String id);

  Future<List<BaseModel>> getCollection() async {
    final firebase = FirebaseService.instance;
    final result = await firebase.getCollection(data: this);
    return (result.map((e) => fromMap(e)).toList());
  }

  Future<void> deleteItem() async {
    if (id.isNotEmpty) {
      final firebase = FirebaseService.instance;
      await firebase.delete(data: this);
    }
  }

  Future<BaseModel> getItem() async {
    final firebase = FirebaseService.instance;
    final result = await firebase.getById(data: this);
    return fromMap(result);
  }

  Future<List<BaseModel>> getCollectionByFilter({
    required List<ConditionModel> listConditions,
  }) async {
    final firebase = FirebaseService.instance;
    final result = await firebase.getByCondition(
      data: this,
      listConditions: listConditions,
    );

    return result.map((e) => fromMap(e)).toList();
  }

  Future<BaseModel> save() async {
    final firebase = FirebaseService.instance;
    if (id.isEmpty) {
      final result = await firebase.create(data: this);
      return this.setid(result.id);
    }

    final result = await firebase.update(data: this);
    return await result.getItem();
  }
}

enum TypeConditions {
  isEqualTo,
  isNotEqualTo,
  isNull,
  isNotNull,
  isGreaterThanOrEqualTo,
  isLessThanOrEqualTo,
}

class ConditionModel {
  final String label;
  final TypeConditions condition;
  final Object? reference;

  const ConditionModel({
    required this.label,
    this.reference,
    this.condition = TypeConditions.isEqualTo,
  });

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'label': label,
      'reference': reference,
    };
  }
}
