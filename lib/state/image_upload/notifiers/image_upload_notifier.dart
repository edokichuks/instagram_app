import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image/image.dart' as img;
import 'package:flutter/foundation.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:instagram_app/state/constants/firebase_collection_name.dart';
import 'package:instagram_app/state/image_upload/constants/contants.dart';
import 'package:instagram_app/state/image_upload/exceptions/could_not_build_thumbnail_exception.dart';
import 'package:instagram_app/state/image_upload/extensions/get_collection_name_from_file_type.dart';
import 'package:instagram_app/state/image_upload/extensions/get_image_data_aspect_ratio.dart';
import 'package:instagram_app/state/image_upload/models/file_type.dart';
import 'package:instagram_app/state/image_upload/typedef/is_loading.dart';
import 'package:instagram_app/state/post/models/post_payload.dart';
import 'package:instagram_app/state/post/typedefs/user_id.dart';
import 'package:instagram_app/state/post_settings/models/post_settings.dart';
import 'package:uuid/uuid.dart';
import 'package:video_thumbnail/video_thumbnail.dart';

class ImageUploadNotifier extends StateNotifier<IsLoading> {
  ImageUploadNotifier() : super(false);
  set isLoading(bool value) => state = value;

  Future<bool> upload({
    required File file,
    required FileType fileType,
    required String message,
    required Map<PostSetting, bool> postSetting,
    required UserId userId,
  }) async {
    isLoading = true;
    late Uint8List thumbnailUnit8List;

    switch (fileType) {
      case FileType.image:
        final fileAsImage = img.decodeImage(file.readAsBytesSync());
        if (fileAsImage == null) {
          isLoading = false;
          throw const CouldNotBuildThumbnailException();
        }
        final thumbnail = img.copyResize(fileAsImage,
            width: ImageConstants.imageThumbnailWidth);

        final thumbnailData = img.encodeJpg(thumbnail);
        thumbnailUnit8List = Uint8List.fromList(thumbnailData);
        break;
      case FileType.video:
        final thumb = await VideoThumbnail.thumbnailData(
          video: file.path,
          imageFormat: ImageFormat.JPEG,
          maxHeight: ImageConstants.vidoeThumbnailMaxHeigh,
          quality: ImageConstants.videoThumbnailQuality,
        );
        if (thumb == null) {
          isLoading = false;
          throw const CouldNotBuildThumbnailException();
        } else {
          thumbnailUnit8List = thumb;
        }

        break;
    }
    final thumbnailAspectRatio = await thumbnailUnit8List.getAspectRatio();

    //cal ref
    final fileName = const Uuid().v4();

    final thumbnailRef = FirebaseStorage.instance
        .ref()
        .child(userId)
        .child(FirebaseCollectionName.thumbnails)
        .child(fileName);

    final originalFileRef = FirebaseStorage.instance
        .ref()
        .child(userId)
        .child(fileType.collectionName)
        .child(fileName);

    try {
      //upload the thumbnail

      final thumbnailUploadTask =
          await thumbnailRef.putData(thumbnailUnit8List);
      final thumbnailStorageId = thumbnailUploadTask.ref.name;

//upload the original file
      final originalFileUploadTask = await originalFileRef.putFile(file);

      final originalFileStorageId = originalFileUploadTask.ref.name;

      //upload the post itself
      final postpayLoad = PostPayload(
          userId: userId,
          message: message,
          thumbnailUrl: await thumbnailRef.getDownloadURL(),
          fileUrl: await originalFileRef.getDownloadURL(),
          fileType: fileType,
          fileName: fileName,
          aspectRatio: thumbnailAspectRatio,
          thumbnailStorageId: thumbnailStorageId,
          originalFileStorageId: originalFileStorageId,
          postSettings: postSetting);

      await FirebaseFirestore.instance
          .collection(FirebaseCollectionName.posts)
          .add(postpayLoad);
      return true;
    } catch (e) {
      return false;
    } finally {
      isLoading = false;
    }
  }
}
