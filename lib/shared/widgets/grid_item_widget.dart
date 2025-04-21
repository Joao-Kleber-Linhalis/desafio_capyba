import 'package:cached_network_image/cached_network_image.dart';
import 'package:desafio_capyba/shared/constants/app_colors.dart';
import 'package:desafio_capyba/shared/constants/app_text_styles.dart';
import 'package:desafio_capyba/shared/constants/images_path.dart';
import 'package:desafio_capyba/shared/models/base_model.dart';
import 'package:flutter/material.dart';

class GridItemWidget extends StatelessWidget {
  final BaseModel item;

  const GridItemWidget({
    super.key,
    required this.item,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      color: item.getColor,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(5),
        side: const BorderSide(color: Colors.black, width: 0.5),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Image
          Expanded(
            child: Hero(
              tag: item.idModel,
              child: ClipRRect(
                borderRadius:
                    const BorderRadius.vertical(top: Radius.circular(5)),
                child: Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: CachedNetworkImageProvider(item.getImageUrl),
                      fit: BoxFit.cover,
                      alignment: Alignment.center,
                    ),
                  ),
                  child: FadeInImage(
                    placeholder: const AssetImage(ImagesPath.profile),
                    image: CachedNetworkImageProvider(item.getImageUrl),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              spacing: 3,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  item.getTitle,
                  style: AppTextStyles.styleBold,
                  overflow: TextOverflow.ellipsis,
                ),
                if (item.getRarity.trim().isNotEmpty)
                  Text(
                    item.getRarity,
                    style: const TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 16,
                    ),
                  ),
                Text(
                  item.getDescription,
                  style: const TextStyle(
                    color: AppColors.descriptionColor,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
