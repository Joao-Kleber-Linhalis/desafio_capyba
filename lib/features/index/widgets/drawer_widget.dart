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
      shape: const Border(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          buildHeader(
            context: context,
            imageUrl: user.photoUrl,
            name: user.name,
          ),
          Expanded(
            child: buildMenuItems(context),
          ),
          const Divider(color: Colors.white24),
          buildLogoutItem(context),
        ],
      ),
    );
  }

  Widget buildHeader({
    required BuildContext context,
    required String imageUrl,
    required String name,
  }) {
    return Container(
      color: AppColors.scaffoldBackgroundColor,
      padding: EdgeInsets.only(
        top: MediaQuery.of(context).padding.top + 16,
        bottom: 16,
      ),
      child: Column(
        children: [
          GestureDetector(
            onTap: () => Feedback.forTap(context),
            child: CircleAvatarWidget(
              imageUrl: imageUrl,
              radius: 70,
            ),
          ),
          const SizedBox(height: 10),
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
    return ListView.builder(
      itemCount: controller.drawerOptions.length,
      itemBuilder: (context, index) {
        final option = controller.drawerOptions[index];
        return ListTile(
          leading: Icon(option.icon),
          title: Text(option.title),
          onTap: () {
            Navigator.of(context).pushNamed(option.route);
          },
        );
      },
    );
  }

  Widget buildLogoutItem(BuildContext context) {
    return ListTile(
      leading: const Icon(Icons.logout),
      title: const Text("Sair"),
      onTap: () {
        Provider.of<AuthProvider>(context, listen: false).logout();
      },
    );
  }
}
