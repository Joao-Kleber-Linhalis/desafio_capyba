import 'package:desafio_capyba/shared/constants/app_colors.dart';
import 'package:desafio_capyba/shared/constants/app_text_styles.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class TakePictureWidget extends StatelessWidget {
  const TakePictureWidget({super.key, required this.onImageSelected});
  final void Function(String? image) onImageSelected;

  Future pickImage({bool fromGallery = true}) async {
    final picker = ImagePicker();
    final pickedImage = await picker.pickImage(
      source: fromGallery ? ImageSource.gallery : ImageSource.camera,
      imageQuality: 50,
      maxWidth: 150,
    );

    if (pickedImage != null) {
      onImageSelected(pickedImage.path);
    } else {
      onImageSelected(null);
    }
  }

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () {
        showModalBottomSheet(
          backgroundColor: AppColors.scaffoldBackgroundColor,
          context: context,
          builder: (context) {
            return SizedBox(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text(
                      "Selecionar imagem",
                      style: AppTextStyles.styleBold,
                    ),
                  ),
                  Divider(color: Colors.grey),
                  ListTile(
                    leading: Icon(
                      Icons.camera_alt,
                      color: AppColors.buttonBackgroundColor,
                    ),
                    title: const Text(
                      "Tirar foto",
                      style: AppTextStyles.style,
                    ),
                    onTap: () {
                      Navigator.of(context).pop();
                      pickImage(fromGallery: false);
                    },
                  ),
                  ListTile(
                    leading: Icon(
                      Icons.photo_library,
                      color: AppColors.buttonBackgroundColor,
                    ),
                    title: const Text(
                      "Escolher da galeria",
                      style: AppTextStyles.style,
                    ),
                    onTap: () {
                      Navigator.of(context).pop();
                      pickImage();
                    },
                  ),
                ],
              ),
            );
          },
        );
      },
      child: const Text("Tirar foto"),
    );
  }
}
