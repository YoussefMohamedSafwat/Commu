import 'dart:io';

import 'package:cleanarch/core/Error/failures.dart';
import 'package:cleanarch/features/user/domain/repositories/user_repository.dart';
import 'package:dartz/dartz.dart';

class UploadImageUsecase {
  final UserRepository userRepository;

  UploadImageUsecase({required this.userRepository});

  Future<Either<Failure, String>> call({
    required String userId,
    required File image,
    required String folder,
    String bucketName = 'avatar',
    String? uniqueFileName,
  }) {
    return userRepository.uploadImage(
      userId: userId,
      image: image,
      folder: folder,
      bucketName: bucketName,
      uniqueFileName: uniqueFileName,
    );
  }
}
