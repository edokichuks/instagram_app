
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:instagram_app/state/comments/models/coment.dart';
import 'package:instagram_app/state/user_info/provider/user_info_model_provider.dart';
import 'package:instagram_app/views/components/animations/small_error_animation_view.dart';
import 'package:instagram_app/views/components/rich_two_parts_text.dart';

class ConpactCommentTile extends ConsumerWidget {
  final Comment comment;
  const ConpactCommentTile({Key? key, required this.comment}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final userInfo = ref.watch(userInfoModelProvider(comment.fromUserId));

    return userInfo.when(
      data: (data) {
        return RichTwoPartText(
          leftPart: data.displayName,
          rightPart: comment.comment,
        );
      },
      error: (error, stackTrace) => const SmallErrorAnimationView(),
      loading: () => const Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}
