import 'package:desafio_capyba/features/home/models/home_model.dart';
import 'package:flutter/material.dart';

class HomeProvider with ChangeNotifier {
  final bool _isAuthenticated;
  List<HomeModel> _items = [];

  List<HomeModel> get homeList => [..._items];

  HomeProvider([
    this._isAuthenticated = false,
  ]);

  int get itemsCount {
    return _items.length;
  }

  bool get isAllowed {
    return _isAuthenticated;
  }

  Future<void> loadhomeList() async {
    if (!isAllowed) return;
    final backupItems = List<HomeModel>.from(_items);
    _items.clear();
    try {
      _items = await HomeModel.empty().getCollection();
    } catch (e) {
      _items = backupItems;
      debugPrint('Erro ao carregar lista: ${e.toString()}');
    }
    notifyListeners();
  }

  Future<void> saveHome(HomeModel home) async {
    if (!isAllowed) return;
    try {
      final saveHome = await home.save();
      if (home.id.isEmpty) {
        _items.add(saveHome);
      } else {
        final index = _items.indexWhere((element) => element.id == home.id);
        if (index >= 0) {
          _items[index] = saveHome;
        }
      }
      notifyListeners();
    } catch (e) {
      debugPrint("Erro ao Salvar: ${e.toString()}");
    }
  }
}
