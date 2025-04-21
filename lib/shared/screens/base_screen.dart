import 'package:desafio_capyba/features/auth/provider/auth_provider.dart';
import 'package:desafio_capyba/shared/constants/app_colors.dart';
import 'package:desafio_capyba/shared/models/base_model.dart';
import 'package:desafio_capyba/shared/widgets/grid_widget.dart';
import 'package:desafio_capyba/shared/widgets/verify_email_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

abstract class BaseScreen<T extends StatefulWidget, P extends ChangeNotifier>
    extends State<T> {
  bool isLoading = true;
  String searchText = '';
  List<BaseModel> getList(P provider);
  bool needEmailVerified = false;

  @override
  Widget build(BuildContext context) {
    final auhtProvider = Provider.of<AuthProvider>(context);
    return (!auhtProvider.isEmailVerified && needEmailVerified)
        ? Center(
            child: VerifyEmailWidget(
              onVerified: () {
                setState(() {});
              },
            ),
          )
        : Consumer<P>(
            builder: (context, provider, child) {
              if (isLoading) {
                return const Center(child: CircularProgressIndicator());
              }

              final list = getList(provider);
              final filteredList = list.where((item) {
                final title = item.getTitle.toLowerCase();
                final description = item.getDescription.toLowerCase();
                final rarity = item.getRarity.toLowerCase().trim();
                final search = searchText.toLowerCase();
                return title.contains(search) ||
                    description.contains(search) ||
                    rarity.contains(search);
              }).toList();

              return Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: SearchBar(
                      backgroundColor: const WidgetStatePropertyAll(
                        AppColors.searchBarBackgroundColor,
                      ),
                      shape: WidgetStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      leading: const Padding(
                        padding: EdgeInsets.only(left: 8.0),
                        child: Icon(
                          Icons.search,
                          color: AppColors.searchBarColor,
                          size: 24,
                        ),
                      ),
                      onChanged: (value) {
                        setState(() {
                          searchText = value;
                        });
                      },
                      hintText: "Pesquisar",
                      textStyle: const WidgetStatePropertyAll(
                        TextStyle(color: AppColors.searchBarColor),
                      ),
                    ),
                  ),
                  filteredList.isEmpty
                      ? Expanded(
                          child: const Center(
                              child: Text("Nenhum item encontrado")))
                      : GridWidget(
                          items: filteredList,
                        ),
                ],
              );
            },
          );
  }
}
