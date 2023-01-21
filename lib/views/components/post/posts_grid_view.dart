import 'package:flutter/material.dart';
import 'package:instagram_app/state/post/models/post.dart';
import 'package:instagram_app/views/components/post/post_thumbnail_view.dart';

class PostGridView extends StatelessWidget {
  final Iterable<Post> posts;
  const PostGridView({
    Key? key,
    required this.posts,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      padding: const EdgeInsets.all(8),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        mainAxisSpacing: 8,
        crossAxisSpacing: 8,

      ),
      itemCount:posts.length ,
      itemBuilder: (context, index) {
        final post = posts.elementAt(index);
        return PostThumbnailView(post: post, onTapped: () {
          //TODO do sth

        });
      },
    );
  }
}
