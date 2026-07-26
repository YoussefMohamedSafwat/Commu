import 'dart:io';
import 'package:cleanarch/core/routing/app_router.dart';
import 'package:cleanarch/core/theming/colors.dart';
import 'package:cleanarch/core/theming/text_styles.dart';
import 'package:cleanarch/core/util/snackbar_message.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:image_cropper/image_cropper.dart';

enum ImageSourceType { camera, gallery }

class ImagePickerHandler {
  ImagePickerHandler._();
  static final ImagePicker _picker = ImagePicker();
  static final ImageCropper _cropper = ImageCropper();

  static Future<List<File>?> pickMultiImage({
    required BuildContext context,
  }) async {
    final source = await _showSourceSelection(context);
    if (source == null) return null;
    try {
      final List<XFile>? pickedFiles = await _picker.pickMultiImage(
        maxWidth: 800,
        maxHeight: 800,
        imageQuality: 85,
      );

      if (pickedFiles == null) return null;
      List<File> files = pickedFiles.map((xfile) => File(xfile.path)).toList();
      return files;
    } catch (e) {
      if (context.mounted) {
        SnackBarMessage().showErrorSnackBar(
          message: "Failed to Pick Image",
          context: context,
        );
      }
      return null;
    }
  }

  static Future<File?> pickImage({
    required BuildContext context,
    bool enableCropping = true,
  }) async {
    final source = await _showSourceSelection(context);
    if (source == null) return null;

    try {
      final XFile? pickedFile = await _picker.pickImage(
        source: source == ImageSourceType.camera
            ? ImageSource.camera
            : ImageSource.gallery,
        maxWidth: 800,
        maxHeight: 800,
        imageQuality: 85,
      );

      if (pickedFile == null) return null;

      if (enableCropping) {
        final croppedFile = await _cropper.cropImage(
          sourcePath: pickedFile.path,
          uiSettings: [
            AndroidUiSettings(
              toolbarTitle: 'Crop Image',
              toolbarColor: AppColors.primary,
              toolbarWidgetColor: Colors.white,
              initAspectRatio: CropAspectRatioPreset.square,
              lockAspectRatio: false,
            ),
            IOSUiSettings(title: 'Crop Image', aspectRatioLockEnabled: false),
          ],
        );

        return croppedFile != null ? File(croppedFile.path) : null;
      }

      return File(pickedFile.path);
    } catch (e) {
      if (context.mounted) {
        SnackBarMessage().showSuccessSnackBar(
          message: "Failed to Pick Image",
          context: context,
        );
      }
      return null;
    }
  }

  static Future<ImageSourceType?> _showSourceSelection(
    BuildContext context,
  ) async {
    debugPrint("=== DEBUG ===");
    debugPrint("context mounted: ${context.mounted}");
    debugPrint("navKey context: ${navKey.currentContext}");
    debugPrint("navKey mounted: ${navKey.currentState?.mounted}");
    return showModalBottomSheet<ImageSourceType>(
      context: navKey.currentContext!,
      useRootNavigator: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) => SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: 40,
                height: 4,
                decoration: BoxDecoration(
                  color: Colors.grey[300],
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
              const SizedBox(height: 20),
              Text('Select Image Source', style: context.heading),
              const SizedBox(height: 20),
              ListTile(
                leading: Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: AppColors.primary.withAlpha(25),
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(Icons.camera_alt, color: AppColors.primary),
                ),
                title: Text('Camera', style: context.body),
                onTap: () => Navigator.pop(context, ImageSourceType.camera),
              ),
              ListTile(
                leading: Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: AppColors.primary.withAlpha(25),
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(
                    Icons.photo_library,
                    color: AppColors.primary,
                  ),
                ),
                title: Text('Gallery', style: context.body),
                onTap: () => Navigator.pop(context, ImageSourceType.gallery),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
