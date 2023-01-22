import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:instagram_app/state/auth/providers/user_id-provider.dart';
import 'package:instagram_app/state/comments/models/coment.dart';
import 'package:instagram_app/state/comments/provider/delete_commen_provider.dart';
import 'package:instagram_app/state/user_info/provider/user_info_model_provider.dart';
import 'package:instagram_app/views/components/animations/loading_animation_view.dart';
import 'package:instagram_app/views/components/animations/small_error_animation_view.dart';
import 'package:instagram_app/views/components/dialogs/alert_dialog_model.dart';
import 'package:instagram_app/views/components/dialogs/delete_dialog.dart';
import 'package:instagram_app/views/constants/string.dart';

class CommentTile extends ConsumerWidget {
  const CommentTile({required this.comment, Key? key}) : super(key: key);
  final Comment comment;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final userInfo = ref.watch(
      userInfoModelProvider(comment.fromUserId),
    );

    return userInfo.when(
      data: (userInforModel) {
        final currentUserId = ref.read(userIdProvider);
        return ListTile(
          trailing: currentUserId == comment.fromUserId
              ? IconButton(
                  onPressed: () async {
                    final shouldDeleteComment =
                        await displayDeleteDialog(context);

                    if (shouldDeleteComment) {
                      await ref
                          .read(deleteCommentProvider.notifier)
                          .deleteComment(commentId: comment.id);
                    }
                  },
                  icon: const Icon(Icons.delete))
              : null,
          title: Text(
            userInforModel.displayName,
          ),
          subtitle: Text(
            comment.comment,
          ),
        );
      },
      error: (error, stackTrace) => const SmallErrorAnimationView(),
      loading: () =>
          const LoadingAnimationView(), //Center(child:  CircularProgressIndicator(),),
    );
  }

  Future<bool> displayDeleteDialog(BuildContext context) =>
      const DeleteDialog(titleOfObjectToDelete: Strings.comment)
          .present(context)
          .then(
            (value) => value ?? false,
          );
}
