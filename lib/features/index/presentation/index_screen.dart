import 'package:desafio_capyba/features/home/presentation/home_screen.dart';
import 'package:desafio_capyba/features/index/controllers/index_controller.dart';
import 'package:desafio_capyba/features/restricted/presentation/restricted_screen.dart';
import 'package:desafio_capyba/shared/constants/app_colors.dart';
import 'package:flutter/material.dart';

class IndexScreen extends StatefulWidget {
  const IndexScreen({super.key});

  @override
  State<IndexScreen> createState() => _IndexScreenState();
}

class _IndexScreenState extends State<IndexScreen> {
  final _widgetOptions = const <Widget>[
    HomeScreen(),
    RestrictedScreen(),
  ];

  final screenController = IndexController.instance;

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<int>(
      valueListenable: screenController.selectedIndexNotifier,
      builder: (context, selectedIndex, child) {
        return Scaffold(
          backgroundColor: AppColors.bottomNavigationBarBackgroundColor,
          body: Center(
            child: _widgetOptions.elementAt(selectedIndex),
          ),
          bottomNavigationBar: BottomNavigationBar(
            items: const <BottomNavigationBarItem>[
              BottomNavigationBarItem(
                icon: Icon(Icons.home),
                label: 'Home',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.security),
                label: 'Restricted',
              ),
            ],
            currentIndex: selectedIndex,
            selectedItemColor: AppColors.bottomNavigationBarItemSelectedColor,
            unselectedItemColor:
                AppColors.bottomNavigationBarItemUnselectedColor,
            type: BottomNavigationBarType.fixed,
            showUnselectedLabels: true,
            onTap: screenController.onItemTapped,
          ),
        );
      },
    );
  }
}
