import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:instagram_app/state/post/providers/user_post_provider.dart';

import 'package:instagram_app/views/components/animations/empty_contents_with_text_animation.dart';
import 'package:instagram_app/views/components/animations/error_animation_views.dart';
import 'package:instagram_app/views/components/animations/loading_animation_view.dart';
import 'package:instagram_app/views/components/post/posts_grid_view.dart';
import 'package:instagram_app/views/constants/string.dart';

class UserPostView extends ConsumerWidget {
  const UserPostView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final posts = ref.watch(userPostsProvider);
    return RefreshIndicator(
        onRefresh: () {
          ref.refresh(userPostsProvider);
          return Future.delayed(
            const Duration(
                seconds:
                    1), //TODO test if this workds () =>      ref.refresh(userPostsProvider)
          );
        },
        child: posts.when(data: (posts) {
          if (posts.isEmpty) {
            return const EmptyContentWithTextAnimationView(
              text: Strings.youHaveNoPosts,
            );
          } else {
            return PostGridView(posts: posts);
          }
        }, error: (error, stackTrace) {
          return const ErrorAnimationView();
        }, loading: () {
          return const LoadingAnimationView();
        }));
  }
}
