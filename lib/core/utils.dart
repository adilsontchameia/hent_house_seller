import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class AppUtilsProvider extends ChangeNotifier {
  void showSnackBar(BuildContext context, String content) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(content),
        duration: const Duration(seconds: 3),
        action: SnackBarAction(
          label: 'Fechar',
          onPressed: () {
            ScaffoldMessenger.of(context).hideCurrentSnackBar();
          },
        ),
      ),
    );
  }

  chooseImage(
    bool isFromGallery,
  ) async {
    XFile? fileImage;
    try {
      final picker = ImagePicker();
      final pickedFile = await picker.pickImage(
        source: isFromGallery ? ImageSource.gallery : ImageSource.camera,
        imageQuality: 20,
      );

      if (pickedFile != null) {
        fileImage = XFile(pickedFile.path);
      } else {
        debugPrint('No Image Selected');
      }
    } catch (e) {
      log('Image: $e');
    }

    notifyListeners();
    return fileImage!;
  }
}
