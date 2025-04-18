import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:desafio_capyba/shared/models/base_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class FirebaseService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;
  final storageRef = FirebaseStorage.instance.ref();
  final auth = FirebaseAuth.instance;

  static FirebaseService? _instance;

  static FirebaseService get instance {
    _instance ??= FirebaseService._();
    return _instance!;
  }
// FUNCOES UTEIS PADRAO

  FirebaseService._() {
    debugPrint("==== FirebaseService =====");
  }

  Future<String?> saveImage(
      File? image, String imageId, String collection) async {
    if (image == null) return null;

    final imageRef = storageRef.child(collection).child(imageId);
    await imageRef.putFile(image).whenComplete(() {});
    return await imageRef.getDownloadURL();
  }

  Future<List<Map<String, dynamic>>> getCollection({
    required BaseModel data,
  }) async {
    if (data.collection.isEmpty) {
      return Future.error(
        "Dados Inváidos para buscar",
        StackTrace.current,
      );
    }
    List<Map<String, dynamic>> list = [];
    try {
      await _db.collection(data.collection).get().then((event) {
        for (var doc in event.docs) {
          list.add(doc.data());
        }
      });
      return list;
    } catch (e, stackTrace) {
      return Future.error(e.toString(), stackTrace);
    }
  }

  Future<Map<String, dynamic>?> getById({
    required BaseModel data,
  }) async {
    if (data.idModel.isEmpty || data.collection.isEmpty) {
      return Future.error("Dados Inváidos para buscar", StackTrace.current);
    }
    try {
      final response =
          await _db.collection(data.collection).doc(data.idModel).get();
      if (response.exists && response.data() != null) {
        print(response.data()!);
        return response.data()!;
      }
      return null;
    } catch (e, stackTrace) {
      return Future.error(e.toString(), stackTrace);
    }
  }

  Future<List<Map<String, dynamic>>> getByCondition({
    required BaseModel data,
    required List<ConditionModel> listConditions,
  }) async {
    try {
      if (listConditions.isEmpty) {
        return Future.error("É necessário pelo menos um filtro");
      }
      List<Map<String, dynamic>> res = [];
      var dbCollection = _db.collection(data.collection);

      Query<Map<String, dynamic>> query = _addWhere(
        query: dbCollection,
        model: listConditions.first,
      );
      for (var e in listConditions.sublist(1, listConditions.length)) {
        query = _addWhere(query: query, model: e);
      }

      final response = await query.get();

      for (var element in response.docs) {
        if (element.exists && element.data().isNotEmpty) {
          res.add(element.data());
        }
      }

      return res;
    } catch (e, stackTrace) {
      return Future.error(e.toString(), stackTrace);
    }
  }

  Query<Map<String, dynamic>> _addWhere(
      {required ConditionModel model,
      CollectionReference<Map<String, dynamic>>? dbCollection,
      Query<Map<String, dynamic>>? query}) {
    var item = dbCollection ?? query;
    if (item != null) {
      if (model.condition == TypeConditions.isEqualTo) {
        return item.where(
          model.label,
          isEqualTo: model.reference,
        );
      }
      if (model.condition == TypeConditions.isNotEqualTo) {
        return item.where(
          model.label,
          isNotEqualTo: model.reference,
        );
      }
      if (model.condition == TypeConditions.isNull) {
        return item.where(model.label, isNull: true);
      }
      if (model.condition == TypeConditions.isNotNull) {
        return item.where(model.label, isNull: false);
      }
    }
    return throw ErrorDescription('Nenhuma lista para filtrar');
  }

  Future<void> delete({
    required BaseModel data,
  }) async {
    if (data.idModel.isEmpty || data.collection.isEmpty) {
      return Future.error("Dados Inváidos para atualizar", StackTrace.current);
    }
    try {
      await _db.collection(data.collection).doc(data.idModel).delete();
    } catch (e, stackTrace) {
      return Future.error(e.toString(), stackTrace);
    }
  }

  Future<BaseModel> create({
    required BaseModel data,
  }) async {
    if (data.collection.isEmpty) {
      return Future.error("Dados Inváidos para cadastrar", StackTrace.current);
    }
    try {
      final map = data.toMap();
      map["createAt"] = DateTime.now();
      final response = await _db.collection(data.collection).add(map);
      return await update(data: data.setIdModel(response.id));
    } catch (e, stackTrace) {
      return Future.error("Erro ao tentar Cadastrar", stackTrace);
    }
  }

  Future<BaseModel> update({
    required BaseModel data,
  }) async {
    if (data.idModel.isEmpty || data.collection.isEmpty) {
      return Future.error("Dados Inváidos para atualizar", StackTrace.current);
    }
    try {
      final map = data.toMap();
      map["updateAt"] = DateTime.now();
      await _db.collection(data.collection).doc(data.idModel).set(
            map,
            SetOptions(
              merge: true,
            ),
          );
      return data;
    } catch (e, stackTrace) {
      return Future.error(e.toString(), stackTrace);
    }
  }
}
