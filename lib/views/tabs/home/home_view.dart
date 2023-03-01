import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:instagram_app/state/post/providers/all_post_provider.dart';
import 'package:instagram_app/views/components/animations/empty_contents_with_text_animation.dart';
import 'package:instagram_app/views/components/animations/error_animation_views.dart';
import 'package:instagram_app/views/components/animations/loading_animation_view.dart';
import 'package:instagram_app/views/components/post/posts_grid_view.dart';
import 'package:instagram_app/views/constants/string.dart';

class HomeView extends ConsumerWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final post = ref.watch(allPostProvider);
    return RefreshIndicator(
      onRefresh: () {
        ref.refresh(allPostProvider);
        return Future.delayed(
          const Duration(seconds: 1),
        );
      },
      child: post.when(data: (post) {
        if (post.isEmpty) {
          return const EmptyContentWithTextAnimationView(
            text: Strings.noPostAvailable,
          );
        } else {
          return PostGridView(
            posts: post,
          );
        }
      }, error: (error, stackTrace) {
        return const ErrorAnimationView();
      }, loading: () {
        return const LoadingAnimationView();
      }),
    );
  }
}
