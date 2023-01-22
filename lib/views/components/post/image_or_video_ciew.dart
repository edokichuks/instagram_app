import 'package:flutter/material.dart';
import 'package:instagram_app/state/image_upload/models/file_type.dart';
import 'package:instagram_app/state/post/models/post.dart';
import 'package:instagram_app/views/components/post/post_image_view.dart';
import 'package:instagram_app/views/components/post/post_video_view.dart';

class PostImageOrVideoView extends StatelessWidget {
  final Post post;
  const PostImageOrVideoView({Key? key, required this.post}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    switch (post.fileType) {
      case FileType.image:
        return PostImageView(
          post: post,
        );
      case FileType.video:
        return PostVideoView(
          post: post,
        );
      default:
        return const SizedBox();
    }
  }
}
