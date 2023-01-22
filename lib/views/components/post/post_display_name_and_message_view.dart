import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:instagram_app/state/auth/providers/user_id-provider.dart';
import 'package:instagram_app/state/post/models/post.dart';
import 'package:instagram_app/state/user_info/provider/user_info_model_provider.dart';
import 'package:instagram_app/views/components/animations/error_animation_views.dart';
import 'package:instagram_app/views/components/animations/small_error_animation_view.dart';
import 'package:instagram_app/views/components/rich_two_parts_text.dart';

class PostDisplayNameAndMessageView extends ConsumerWidget {
  const PostDisplayNameAndMessageView({required this.post, Key? key})
      : super(key: key);
  final Post post;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final userInfoModel = ref.watch(
      userInfoModelProvider(
        post.userId,
      ),
    );
    return userInfoModel.when(
      data: (data) {
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: RichTwoPartText(
              leftPart: data.displayName, rightPart: post.message),
        );
      },
      error: (error, stackTrace) => const SmallErrorAnimationView(),
      loading: () => const Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}
