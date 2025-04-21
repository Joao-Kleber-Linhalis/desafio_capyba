import 'package:desafio_capyba/features/create/controllers/create_controller.dart';
import 'package:desafio_capyba/shared/constants/app_text_styles.dart';
import 'package:desafio_capyba/shared/constants/rarity.dart';
import 'package:desafio_capyba/shared/utils/responsive.dart';
import 'package:desafio_capyba/shared/utils/tools.dart';
import 'package:desafio_capyba/shared/widgets/button_widget.dart';
import 'package:desafio_capyba/shared/widgets/circle_avatar_widget.dart';
import 'package:desafio_capyba/shared/widgets/take_picture_widget.dart';
import 'package:desafio_capyba/shared/widgets/verify_email_widget.dart';
import 'package:flutter/material.dart';

class CreateScreen extends StatefulWidget {
  const CreateScreen({super.key});

  @override
  State<CreateScreen> createState() => _CreateScreenState();
}

class _CreateScreenState extends State<CreateScreen> {
  late final CreateController _controller;

  @override
  void initState() {
    _controller = CreateController(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Criar Registro'),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Center(
          child: _controller.isEmailVerified
              ? SingleChildScrollView(
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
                                  spacing: 5,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    CircleAvatarWidget(
                                      imageUrl: _controller.photoUrl,
                                      radius: Responsive.screenWidth(context) *
                                          0.25,
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
                                          labelText: "Nome"),
                                      keyboardType: TextInputType.name,
                                      validator: (_name) {
                                        final name = _name ?? '';
                                        if (name.trim().isEmpty ||
                                            name.length <= 3) {
                                          return 'Informe um nome válido';
                                        }
                                        return null;
                                      },
                                    ),
                                    TextFormField(
                                      controller:
                                          _controller.descriptionController,
                                      style: AppTextStyles.style,
                                      decoration: const InputDecoration(
                                          labelText: "Descrição"),
                                      keyboardType: TextInputType.name,
                                      validator: (_description) {
                                        final description = _description ?? '';
                                        if (description.trim().isEmpty ||
                                            description.length <= 3) {
                                          return 'Informe uma descrição válida';
                                        }
                                        return null;
                                      },
                                    ),
                                    Row(
                                      children: _controller.types.map((type) {
                                        return Expanded(
                                          child: RadioListTile<String>(
                                            dense: true,
                                            title: Text(type),
                                            value: type,
                                            groupValue: _controller.type,
                                            onChanged: (value) {
                                              setState(() {
                                                _controller.type = value!;
                                              });
                                            },
                                          ),
                                        );
                                      }).toList(),
                                    ),
                                    Visibility(
                                      visible: _controller.type == "Restricted",
                                      child: Row(
                                        spacing: 10,
                                        children: [
                                          Text(
                                            "Raridade",
                                            style: AppTextStyles.style,
                                          ),
                                          DropdownButton(
                                            value: _controller.rarity,
                                            items: Rarity.rarities
                                                .map((rarity) =>
                                                    DropdownMenuItem(
                                                      value: rarity,
                                                      child: Text(rarity),
                                                    ))
                                                .toList(),
                                            onChanged: (value) {
                                              setState(() {
                                                _controller.rarity = value!;
                                              });
                                            },
                                          ),
                                        ],
                                      ),
                                    ),
                                    ButtonWidget(
                                      isLoading: _controller.isLoading,
                                      child: Text(
                                        "Salvar Registro",
                                        style: AppTextStyles.style,
                                      ),
                                      onPressed: () => _controller.submit(
                                        context,
                                        () => setState(
                                            () => _controller.isLoading = true),
                                        () => setState(() =>
                                            _controller.isLoading = false),
                                      ),
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
                )
              : VerifyEmailWidget(
                  onVerified: () => setState(() {
                    _controller.verify(context);
                  }),
                ),
        ),
      ),
    );
  }
}
