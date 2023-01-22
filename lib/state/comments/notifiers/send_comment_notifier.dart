import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:instagram_app/state/comments/models/comment_payload.dart';
import 'package:instagram_app/state/constants/firebase_collection_name.dart';
import 'package:instagram_app/state/image_upload/typedef/is_loading.dart';
import 'package:instagram_app/state/post/typedefs/post_id.dart';
import 'package:instagram_app/state/post/typedefs/user_id.dart';

class SendCommentNotifier extends StateNotifier<IsLoading> {
  SendCommentNotifier() : super(false);

  set isLoading(bool value) => state = value;
  Future<bool> sendComment(
      {required UserId fromUserId,
      required PostId onPostId,
      required String comment}) async {
    try {
      isLoading = true;

      final payload = CommentPayload(
        fromUserId: fromUserId,
        onPostId: onPostId,
        comment: comment,
      );

      await FirebaseFirestore.instance
          .collection(FirebaseCollectionName.comments)
          .add(payload);
      return true;
    } catch (e) {
      return false;
    } finally {
      isLoading = false;
    }
  }
}
