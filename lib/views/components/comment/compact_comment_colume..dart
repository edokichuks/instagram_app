import 'package:flutter/material.dart';
import 'package:instagram_app/state/comments/models/coment.dart';

class CompactCommentConlume extends StatelessWidget {
  final Iterable<Comment> comments;

  const CompactCommentConlume({Key? key, required this.comments})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (comments.isEmpty) {
      return const SizedBox.shrink();
    } else {
      return Padding(
        padding: const EdgeInsets.only(
          left: 8,
          right: 8.0,
          bottom: 8.0,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: comments.map(
            (comment) {
              return CompactCommentConlume(
                comments: comments,
              );
            },
          ).toList(),
        ),
      );
    }
  }
}
