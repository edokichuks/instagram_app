import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:instagram_app/state/likes/providers/posts_like_count_provider.dart';
import 'package:instagram_app/state/post/typedefs/post_id.dart';
import 'package:instagram_app/views/components/animations/small_error_animation_view.dart';
import 'package:instagram_app/views/constants/string.dart';

class LikesCountView extends ConsumerWidget {
  final PostId postId;
  const LikesCountView({
    Key? key,
    required this.postId,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final likesCount = ref.watch(
      postLikesCountProvider(postId),
    );
    return likesCount.when(
      data: (int likeCount) {
        final personOrPeople = likeCount == 1 ? Strings.person : Strings.people;

        final likesText = '$likeCount $personOrPeople ${Strings.likedThis}';

        return Text(
          likesText,
        );
      },
      error: (error, stackTrace) => const SmallErrorAnimationView(),
      loading: () => const Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}
