import 'package:desafio_capyba/core/routes/app_routes.dart';
import 'package:desafio_capyba/features/index/models/drawer_options_model.dart';
import 'package:flutter/material.dart';

class DrawerController {
  static DrawerController? _instance;

  static DrawerController get instance {
    _instance ??= DrawerController._();
    return _instance!;
  }

  DrawerController._() {
    debugPrint("==== DrawerController =====");
  }

  List<DrawerOptionsModel> drawerOptions = [
    DrawerOptionsModel(
      title: "Meu perfil",
      icon: Icons.person,
      route: AppRoutes.PROFILE_SCREEN,
    ),
    DrawerOptionsModel(
      title: "Abrir CapyLoot",
      icon: Icons.card_giftcard,
      route: AppRoutes.WHEEL_SCREEN,
    ),
    DrawerOptionsModel(
      title: "Criar registro",
      icon: Icons.add,
      route: AppRoutes.CREATE_SCREEN,
    )
  ];
}
