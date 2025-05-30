import 'dart:io';
import 'dart:math';

import 'package:desafio_capyba/core/services/firebase_service.dart';
import 'package:desafio_capyba/features/restricted/models/restricted_model.dart';
import 'package:flutter/material.dart';

class RestrictedProvider with ChangeNotifier {
  final bool _isAuthenticated;
  final bool _emailVerified;
  final List<String> _userRestrictedItems;
  List<RestrictedModel> _items = [];
  List<RestrictedModel> _userItems = [];

  List<RestrictedModel> get restrictedList => [..._items];
  List<RestrictedModel> get userRestrictedList => [..._userItems];

  RestrictedProvider([
    this._isAuthenticated = false,
    this._emailVerified = false,
    this._userRestrictedItems = const [],
  ]);

  int get itemsCount {
    return _items.length;
  }

  bool get isAllowed {
    return _isAuthenticated && _emailVerified;
  }

  Future<void> loadRestrictedList() async {
    if (!isAllowed) return;
    final backupItems = List<RestrictedModel>.from(_items);
    _items.clear();

    try {
      _items = await RestrictedModel.empty().getCollection();
      _userItems.clear();
      _userItems = _items
          .where((item) => _userRestrictedItems.contains(item.id))
          .toList();
    } catch (e) {
      _items = backupItems;
      debugPrint('Erro ao carregar lista: ${e.toString()}');
    }
    notifyListeners();
  }

  Future<void> saveRestricted(
      RestrictedModel restricted, String photoUrl) async {
    if (!isAllowed) return;
    try {
      RestrictedModel saveRestricted = await restricted.save();
      if (!photoUrl.contains("http")) {
        String photoFirebaseUrl = await FirebaseService.instance.saveImage(
                File(photoUrl), saveRestricted.id, saveRestricted.collection) ??
            "";
        saveRestricted =
            await saveRestricted.copyWith(imageUrl: photoFirebaseUrl).save();
      }
      if (restricted.id.isEmpty) {
        _items.add(saveRestricted);
      } else {
        final index =
            _items.indexWhere((element) => element.id == restricted.id);
        if (index >= 0) {
          _items[index] = saveRestricted;
        }
        if (_userRestrictedItems.contains(saveRestricted.id)) {
          final idx = _userItems.indexWhere((e) => e.id == saveRestricted.id);
          if (idx >= 0) {
            _userItems[idx] = saveRestricted;
          } else {
            _userItems.add(saveRestricted);
          }
        }
      }
      notifyListeners();
    } catch (e) {
      debugPrint("Erro ao Salvar: ${e.toString()}");
    }
  }

  Future<RestrictedModel> getRandomItemByRarity(String rarity) async {
    if (_items.isEmpty) await loadRestrictedList();
    final filteredItems =
        _items.where((item) => item.rarity == rarity).toList();
    final random = Random();
    final index = random.nextInt(filteredItems.length);
    return filteredItems[index];
  }
}
