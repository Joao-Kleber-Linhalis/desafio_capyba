import 'package:desafio_capyba/core/services/firebase_service.dart';

abstract class BaseModel<T> {
  String get idModel;
  String get collection;
  T fromMap(Map<String, dynamic>? map);
  Map<String, dynamic> toMap();
  T setIdModel(String id);

  Future<List<T>> getCollection() async {
    final firebase = FirebaseService.instance;
    final result = await firebase.getCollection(data: this);
    return (result.map((e) => fromMap(e)).toList());
  }

  Future<void> deleteItem() async {
    if (idModel.isNotEmpty) {
      final firebase = FirebaseService.instance;
      await firebase.delete(data: this);
    }
  }

  Future<T> getItem() async {
    final firebase = FirebaseService.instance;
    final result = await firebase.getById(data: this);
    return fromMap(result);
  }

  Future<List<T>> getCollectionByFilter({
    required List<ConditionModel> listConditions,
  }) async {
    final firebase = FirebaseService.instance;
    final result = await firebase.getByCondition(
      data: this,
      listConditions: listConditions,
    );

    return result.map((e) => fromMap(e)).toList();
  }

  Future<T> save() async {
    final firebase = FirebaseService.instance;
    if (idModel.isEmpty) {
      final result = await firebase.create(data: this);
      return this.setIdModel(result.idModel);
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
