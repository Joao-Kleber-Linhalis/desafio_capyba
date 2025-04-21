import 'package:desafio_capyba/features/home/models/home_model.dart';
import 'package:desafio_capyba/features/home/provider/home_provider.dart';
import 'package:desafio_capyba/shared/screens/base_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends BaseScreen<HomeScreen, HomeProvider> {
  @override
  List<HomeModel> getList(HomeProvider provider) => provider.homeList;

  @override
  void initState() {
    super.initState();
    Provider.of<HomeProvider>(context, listen: false).loadhomeList().then((_) {
      setState(() {
        isLoading = false;
      });
    });
  }
}
