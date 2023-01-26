import 'package:flutter/material.dart';
import 'package:instagram_app/state/post/models/post.dart';
import 'package:instagram_app/views/components/post/post_thumbnail_view.dart';
import 'package:instagram_app/views/post_details/post_details_view.dart';

class PostSilverGridView extends StatelessWidget {
  final Iterable<Post> posts;
  const PostSilverGridView({Key? key, required this.posts}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SliverGrid(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        mainAxisSpacing: 8,
        crossAxisSpacing: 8,
      ),
      delegate: SliverChildBuilderDelegate(
        childCount: posts.length,
        (context, index) {
                final post = posts.elementAt(index);
        return PostThumbnailView(
            post: post,
            onTapped: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => PostDetailsView(
                    post: post,
                  ),
                ),
              );
            });
        }),
    );
  }
}
