import 'package:desafio_capyba/features/auth/provider/auth_provider.dart';
import 'package:desafio_capyba/features/restricted/models/restricted_model.dart';
import 'package:desafio_capyba/features/restricted/provider/restricted_provider.dart';
import 'package:desafio_capyba/shared/constants/app_text_styles.dart';
import 'package:desafio_capyba/shared/constants/rarity.dart';
import 'package:desafio_capyba/shared/widgets/circle_avatar_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class WheelDialog extends StatefulWidget {
  final String rarity;
  const WheelDialog({super.key, required this.rarity});

  @override
  State<WheelDialog> createState() => _WheelDialogState();
}

class _WheelDialogState extends State<WheelDialog> {
  bool _isLoading = true;
  late RestrictedModel _capyWin;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      final provider = Provider.of<RestrictedProvider>(context, listen: false);
      _capyWin =
          await provider.getRandomItemByRarity(widget.rarity).then((value) {
        setState(() {
          _isLoading = false;
        });
        return value;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      elevation: 0,
      backgroundColor: Colors.transparent,
      child: _isLoading
          ? SizedBox(
              width: double.infinity,
              height: double.infinity,
              child: const Center(child: CircularProgressIndicator()))
          : contentBox(context),
    );
  }

  Widget contentBox(BuildContext context) {
    return Stack(
      children: [
        Container(
          width: double.infinity,
          padding: const EdgeInsets.only(
            top: 100,
            bottom: 16,
            left: 16,
            right: 16,
          ),
          margin: const EdgeInsets.only(top: 16),
          decoration: BoxDecoration(
            shape: BoxShape.rectangle,
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
            boxShadow: const [
              BoxShadow(
                color: Colors.black,
                offset: Offset(0, 10),
                blurRadius: 10,
              ),
            ],
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              FittedBox(
                child:
                    Text("Parabéns! Você ganhou a", style: AppTextStyles.style),
              ),
              FittedBox(
                child: Text(
                  _capyWin.title,
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Rarity.getColorForRarity(_capyWin.rarity),
                  ),
                ),
              ),
              FittedBox(
                child: Text(
                  _capyWin.rarity,
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                    color: Rarity.getColorForRarity(_capyWin.rarity),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              CircleAvatarWidget(
                imageUrl: _capyWin.imageUrl,
                radius: 100,
              ),
              const SizedBox(height: 20),
              InkWell(
                onTap: () async {
                  await Provider.of<AuthProvider>(context, listen: false)
                      .saveRestrictedItem(_capyWin.idModel);
                  Navigator.of(context).pop();
                },
                child: const Icon(
                  Icons.save,
                  size: 40,
                  color: Colors.blue, // Cor do ícone de voltar
                ),
              ),
            ],
          ),
        ),
        Positioned(
          top: 0,
          left: 16,
          right: 16,
          child: CircleAvatar(
            backgroundColor: Colors.green,
            radius: 50,
            backgroundImage: AssetImage(
              Rarity.getStoneForRarity(_capyWin.rarity),
            ),
          ),
        ),
      ],
    );
  }
}
