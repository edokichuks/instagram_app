import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:instagram_app/state/constants/firebase_collection_name.dart';
import 'package:instagram_app/state/constants/firebase_field_name.dart';
import 'package:instagram_app/state/image_upload/extensions/get_collection_name_from_file_type.dart';
import 'package:instagram_app/state/image_upload/typedef/is_loading.dart';
import 'package:instagram_app/state/post/models/post.dart';
import 'package:instagram_app/state/post/typedefs/post_id.dart';

class DeletePostStateNotifier extends StateNotifier<IsLoading> {
  DeletePostStateNotifier() : super(false);
  set isLoading(bool value) => state = value;

  Future<bool> deletPost({required Post post}) async {
    try {
      isLoading = true;

      ///delete the post's thumbnail
      await FirebaseStorage.instance
          .ref()
          .child(post.userId)
          .child(FirebaseCollectionName.thumbnails)
          .child(post.thumbnailStorageId)
          .delete();

      ///delete post original
      await FirebaseStorage.instance
          .ref()
          .child(post.userId)
          .child(post.fileType.collectionName)
          .child(post.originalFileStorageId)
          .delete();

      //delte all the comment
      await _deleteAllDocument(
        postId: post.postId,
        inCollection: FirebaseCollectionName.comments,
      );
      //delte all the like
      await _deleteAllDocument(
        postId: post.postId,
        inCollection: FirebaseCollectionName.likes,
      );
      //delte all the post finally
      final postIncollection = await FirebaseFirestore.instance
          .collection(FirebaseCollectionName.posts)
          .where(
            FieldPath.documentId,
            isEqualTo: post.postId,
          )
          .limit(1)
          .get();

      for (final post in postIncollection.docs) {
        await post.reference.delete();
      }

      return true;
    } catch (_) {
      return false;
    } finally {
      isLoading = false;
    }
  }

  Future<void> _deleteAllDocument(
      {required PostId postId, required String inCollection}) {
    return FirebaseFirestore.instance.runTransaction(
      maxAttempts: 3,
      timeout: const Duration(
        seconds: 20,
      ),
      (transaction) async {
        final query = await FirebaseFirestore.instance
            .collection(inCollection)
            .where(FirebaseFieldName.postId, isEqualTo: postId)
            .get();

        for (final doc in query.docs) {
          transaction.delete(
            doc.reference,
          );
        }
      },
    );
  }
}
