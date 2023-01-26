import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:instagram_app/state/auth/providers/auth_state_provider.dart';
import 'package:instagram_app/state/comments/provider/delete_commen_provider.dart';
import 'package:instagram_app/state/comments/provider/send_comment_provider.dart';
import 'package:instagram_app/state/image_upload/provider/image_uploader_provider.dart';
import 'package:instagram_app/state/post/providers/delete_post_provider.dart';

final isLoadingProvider = Provider<bool>(
  (ref) {
    final authState = ref.watch(authStateProvider);
    final isUploadingImage = ref.watch(imageUploaderProvider);
    final isSendingComment = ref.watch(sendCommentProvider);
    final isDeletingComment = ref.watch(deleteCommentProvider);
    final isDeletingPost = ref.watch(deletePostProvider);
    return authState.isLoading ||
        isUploadingImage ||
        isSendingComment ||
        isDeletingPost ||
        isDeletingComment;
  },
);
