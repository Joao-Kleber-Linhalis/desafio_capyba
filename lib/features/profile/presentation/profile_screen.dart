import 'package:desafio_capyba/features/profile/controllers/profile_controller.dart';
import 'package:desafio_capyba/shared/constants/app_colors.dart';
import 'package:desafio_capyba/shared/constants/app_text_styles.dart';
import 'package:desafio_capyba/shared/utils/responsive.dart';
import 'package:desafio_capyba/shared/utils/tools.dart';
import 'package:desafio_capyba/shared/widgets/button_widget.dart';
import 'package:desafio_capyba/shared/widgets/circle_avatar_widget.dart';
import 'package:desafio_capyba/shared/widgets/take_picture_widget.dart';
import 'package:flutter/material.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  late final ProfileController _controller;

  @override
  void initState() {
    _controller = ProfileController(context);
    super.initState();
  }

  _showDatePicker() {
    showDatePicker(
      context: context,
      initialDate: _controller.birthDate,
      firstDate: DateTime.now().subtract(Duration(days: 365 * 100)),
      lastDate: DateTime.now(),
      locale: const Locale('pt', 'BR'),
    ).then((pickedDate) {
      if (pickedDate == null) {
        return;
      }
      setState(() {
        _controller.birthDate = pickedDate;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Perfil do Usuário'),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            child: SizedBox(
              width: double.infinity,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    padding: const EdgeInsets.all(16),
                    child: Card(
                      elevation: 8,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(16),
                        child: Form(
                          key: _controller.formKey,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              CircleAvatarWidget(
                                imageUrl: _controller.photoUrl,
                                radius: Responsive.screenWidth(context) * 0.25,
                              ),
                              TakePictureWidget(onImageSelected: (path) {
                                if (path == null) {
                                  Tools.showErrorDialog(
                                    'Erro ao selecionar imagem',
                                    context,
                                  );
                                  return;
                                }
                                setState(() {
                                  _controller.setPhotoUrl(path);
                                });
                              }),
                              TextFormField(
                                controller: _controller.nameController,
                                style: AppTextStyles.style,
                                decoration: const InputDecoration(
                                    labelText: "Seu nome"),
                                keyboardType: TextInputType.name,
                                validator: (_name) {
                                  final name = _name ?? '';
                                  if (name.trim().isEmpty || name.length <= 3) {
                                    return 'Informe um nome válido';
                                  }
                                  return null;
                                },
                              ),
                              SizedBox(
                                height: 70,
                                child: Row(
                                  children: <Widget>[
                                    Expanded(
                                      child: Text(
                                        'Data Nascimento: ${Tools.formatDateToString(_controller.birthDate)}',
                                        style: AppTextStyles.style,
                                      ),
                                    ),
                                    TextButton(
                                      onPressed: _showDatePicker,
                                      style: TextButton.styleFrom(
                                        backgroundColor:
                                            AppColors.buttonBackgroundColor,
                                      ),
                                      child: const Text(
                                        'Selecionar Data',
                                        style: AppTextStyles.style,
                                      ),
                                    )
                                  ],
                                ),
                              ),
                              ButtonWidget(
                                isLoading: _controller.isLoading,
                                child: Text(
                                  "Salvar Perfil",
                                  style: AppTextStyles.style,
                                ),
                                onPressed: () => _controller.submit(
                                    context,
                                    () => setState(
                                        () => _controller.isLoading = true),
                                    () => setState(
                                        () => _controller.isLoading = false)),
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
