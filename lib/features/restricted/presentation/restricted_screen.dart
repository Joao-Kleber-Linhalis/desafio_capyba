import 'package:desafio_capyba/features/restricted/models/restricted_model.dart';
import 'package:desafio_capyba/features/restricted/provider/restricted_provider.dart';
import 'package:desafio_capyba/shared/screens/base_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class RestrictedScreen extends StatefulWidget {
  const RestrictedScreen({super.key});

  @override
  State<RestrictedScreen> createState() => _RestrictedScreenState();
}

class _RestrictedScreenState
    extends BaseScreen<RestrictedScreen, RestrictedProvider> {
  @override
  bool get needEmailVerified => true;

  @override
  List<RestrictedModel> getList(RestrictedProvider provider) =>
      provider.userRestrictedList;

  @override
  void initState() {
    super.initState();
    Provider.of<RestrictedProvider>(context, listen: false)
        .loadRestrictedList()
        .then((_) {
      setState(() {
        isLoading = false;
      });
    });
  }
}
