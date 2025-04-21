import 'package:desafio_capyba/features/home/provider/home_provider.dart';
import 'package:desafio_capyba/shared/widgets/grid_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool isLoading = true;
  String searchText = '';

  @override
  void initState() {
    super.initState();

    Provider.of<HomeProvider>(context, listen: false).loadhomeList().then((_) {
      setState(() {
        isLoading = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<HomeProvider>(
      builder: (context, provider, child) {
        if (isLoading) {
          return const Center(child: CircularProgressIndicator());
        }

        // Filtrando a lista com base na busca
        final filteredList = provider.homeList.where((item) {
          return item.title.toLowerCase().contains(searchText.toLowerCase()) ||
              item.description.toLowerCase().contains(searchText.toLowerCase());
        }).toList();

        return Column(
          children: [
            // 🔍 SearchBar no topo
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: TextField(
                decoration: const InputDecoration(
                  hintText: 'Buscar por título ou descrição...',
                  prefixIcon: Icon(Icons.search),
                  border: OutlineInputBorder(),
                ),
                onChanged: (value) {
                  setState(() {
                    searchText = value;
                  });
                },
              ),
            ),

            // Lista filtrada
            filteredList.isEmpty
                ? const Center(child: Text("Nenhum item encontrado"))
                : GridWidget(
                    items: filteredList,
                  ),
          ],
        );
      },
    );
  }
}
