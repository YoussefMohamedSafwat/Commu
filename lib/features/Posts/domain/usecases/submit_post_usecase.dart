import 'package:cleanarch/core/usecases/upload_image_usecase.dart';
import 'package:cleanarch/core/util/post_image.dart';
import 'package:uuid/uuid.dart';

class SubmitPostUsecase {
  final UploadImageUsecase uploadImageUsecase;
  SubmitPostUsecase(this.uploadImageUsecase);

  Future<List<String>> resolveImageUrls(
    String userId,
    List<PostImage> images,
  ) async {
    const uuid = Uuid();
    final futures = images.map((img) async {
      if (img.isLocal) {
        final response = await uploadImageUsecase(
          userId: userId,
          image: img.localFile!,
          folder: "posts",
          bucketName: "Posts",
          uniqueFileName: "post_${uuid.v4()}",
        );
        return response.fold(
          (failure) => throw Exception("Failed to upload image"),
          (url) => url,
        );
      } else {
        return img.url!;
      }
    });
    return await Future.wait(futures);
  }
}
