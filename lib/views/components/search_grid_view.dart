import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:instagram_app/state/post/providers/post_by_search_term_provider.dart';
import 'package:instagram_app/views/components/animations/data_not_found_animation_view.dart';
import 'package:instagram_app/views/components/animations/empty_contents_with_text_animation.dart';
import 'package:instagram_app/views/components/animations/error_animation_views.dart';
import 'package:instagram_app/views/components/post/post_silver_grid_view.dart';
import 'package:instagram_app/views/components/post/posts_grid_view.dart';
import 'package:instagram_app/views/constants/string.dart';

class SearchGridView extends ConsumerWidget {
  final String searchTerm;
  const SearchGridView({
    Key? key,
    required this.searchTerm,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    if (searchTerm.isEmpty) {
      return const SliverToBoxAdapter(
        child:  EmptyContentWithTextAnimationView(
            text: Strings.enterYourSearchTerm),
      );
    }
    final post = ref.watch(
      postBySearchTermProvider(searchTerm),
    );
    return post.when(
      data: (post) {
        if (post.isEmpty) {
          return const SliverToBoxAdapter(child: DataNotFoundAnimationView());
        } else {
          return PostSilverGridView(posts: post);
        }
      },
      error: (error, stackTrace) =>const  SliverToBoxAdapter(child: ErrorAnimationView()),
      loading: () =>const  SliverToBoxAdapter(child: Center(child: CircularProgressIndicator())),
    );
  }
}
