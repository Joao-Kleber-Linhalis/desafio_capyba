import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:desafio_capyba/shared/constants/images_path.dart';
import 'package:flutter/material.dart';

class CircleAvatarWidget extends StatelessWidget {
  final String imageUrl;
  final double radius;

  const CircleAvatarWidget({
    super.key,
    required this.imageUrl,
    required this.radius,
  });

  bool _isLocalPath(String path) {
    return !path.startsWith('http://') && !path.startsWith('https://');
  }

  @override
  Widget build(BuildContext context) {
    if (imageUrl.trim().isEmpty) {
      return CircleAvatar(
        radius: radius,
        backgroundImage: AssetImage(ImagesPath.profile),
      );
    }

    if (_isLocalPath(imageUrl)) {
      return CircleAvatar(
        radius: radius,
        backgroundImage: FileImage(File(imageUrl)),
      );
    }

    return CachedNetworkImage(
      imageUrl: imageUrl,
      placeholder: (context, url) => CircleAvatar(
        radius: radius,
        backgroundColor: Colors.grey[300],
        child: const CircularProgressIndicator(color: Colors.black),
      ),
      errorWidget: (context, url, error) => CircleAvatar(
        radius: radius,
        backgroundImage: AssetImage(ImagesPath.profile),
      ),
      imageBuilder: (context, imageProvider) => CircleAvatar(
        backgroundImage: imageProvider,
        radius: radius,
      ),
    );
  }
}
