import 'package:flutter/material.dart';
import 'package:instagram_app/state/post/models/post.dart';

class PostImageView extends StatelessWidget {
  final Post post;
  const PostImageView({Key? key, required this.post}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: post.aspectRatio,
      child: Image.network(
        post.fileUrl,
        loadingBuilder: (context, child, loadingProgress) {
          if (loadingProgress == null) return child;
          return const Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
    );
  }
}
