import 'package:desafio_capyba/features/auth/provider/auth_provider.dart';
import 'package:desafio_capyba/shared/constants/app_colors.dart';
import 'package:desafio_capyba/shared/constants/app_text_styles.dart';
import 'package:desafio_capyba/shared/widgets/circle_avatar_widget.dart';
import 'package:desafio_capyba/features/index/controllers/drawer_controller.dart'
    as my_drawer_controller;
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class DrawerWidget extends StatelessWidget {
  final controller = my_drawer_controller.DrawerController.instance;
  DrawerWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<AuthProvider>(context).userModel;
    return Drawer(
        backgroundColor: AppColors.scaffoldBackgroundColor,
        shape: const Border(),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              buildHeader(
                context: context,
                imageUrl: user.photoUrl,
                name: user.name,
              ),
              buildMenuItems(context),
              ListTile(
                leading: Icon(Icons.logout),
                title: Text("Sair"),
                onTap: () {
                  Provider.of<AuthProvider>(context, listen: false).logout();
                },
              ),
            ],
          ),
        ));
  }

  Widget buildHeader({
    required BuildContext context,
    required String imageUrl,
    required String name,
  }) {
    return Container(
      padding: EdgeInsets.only(
        top: MediaQuery.of(context).padding.top,
      ),
      child: Column(
        spacing: 10,
        children: [
          GestureDetector(
            onTap: () {
              //Feedback de toque, emiti o som de clique
              Feedback.forTap(context);
            },
            child: CircleAvatarWidget(
              imageUrl: imageUrl,
              radius: 70,
            ),
          ),
          Text(
            name,
            textAlign: TextAlign.center,
            overflow: TextOverflow.ellipsis,
            style: AppTextStyles.styleBold,
          ),
        ],
      ),
    );
  }

  Widget buildMenuItems(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Wrap(
        runSpacing: 5,
        children: controller.drawerOptions.map((option) {
          return ListTile(
            leading: Icon(option.icon),
            title: Text(option.title),
            onTap: (){
              Navigator.of(context).pushNamed(option.route);
            },
          );
        }).toList(),
      ),
    );
  }
}
