import 'dart:collection';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart' show immutable;
import 'package:instagram_app/state/image_upload/models/file_type.dart';
import 'package:instagram_app/state/post/models/post_key.dart';
import 'package:instagram_app/state/post/typedefs/user_id.dart';
import 'package:instagram_app/state/post_settings/models/post_settings.dart';

@immutable
class PostPayload extends MapView<String, dynamic> {
  PostPayload({
    required UserId userId,
    required String message,
    required String thumbnailUrl,
    required String fileUrl,
    required FileType fileType,
    required String fileName,
    required double aspectRatio,
    required String thumbnailStorageId,
    required String originalFileStorageId,
    required Map<PostSetting, bool> postSettings,
  }) : super({
    PostKey.userId: userId,
    PostKey.message : message,
    PostKey.createdAt: FieldValue.serverTimestamp(),
    PostKey.thumbnailUrl: thumbnailUrl,
    PostKey.fileUrl: fileUrl,
    PostKey.fileType:fileType.name,
    PostKey.fileName: fileName,
    PostKey.aspectRatio: aspectRatio,
    PostKey.thumbnailStorageId: thumbnailStorageId,
    PostKey.originalFileStorageId: originalFileStorageId,
    PostKey.postSetttings: {
      for(final postSetting in postSettings.entries)
      postSetting.key.storageKey: postSetting.value
    }
  });
}
