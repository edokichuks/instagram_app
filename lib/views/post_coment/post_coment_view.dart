import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:instagram_app/state/auth/providers/user_id-provider.dart';
import 'package:instagram_app/state/comments/models/post_comment_requests.dart';
import 'package:instagram_app/state/comments/provider/post_comments_provider.dart';
import 'package:instagram_app/state/comments/provider/send_comment_provider.dart';
import 'package:instagram_app/state/post/typedefs/post_id.dart';
import 'package:instagram_app/views/components/animations/empty_contents_with_text_animation.dart';
import 'package:instagram_app/views/components/animations/error_animation_views.dart';
import 'package:instagram_app/views/components/animations/loading_animation_view.dart';
import 'package:instagram_app/views/components/comment/comment_tile.dart';
import 'package:instagram_app/views/constants/string.dart';
import 'package:instagram_app/views/extensions/dismiss_keyboard.dart';

class PostCommentView extends HookConsumerWidget {
  const PostCommentView({
    Key? key,
    required this.postId,
  }) : super(key: key);
  final PostId postId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final commentController = useTextEditingController();

    final hasText = useState(false);

    final request = useState(RequestForPostAndComment(
      postId: postId,
    ));
    final comments = ref.watch(
      postCommentsProvider(request.value),
    );

    useEffect(
      () {
        commentController.addListener(() {
          hasText.value = commentController.text.isNotEmpty;
        });
        return () {};
      },
      [commentController],
    );
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          Strings.comments,
        ),
        actions: [
          IconButton(
            onPressed: hasText.value
                ? () {
                    _submitCommentWithController(commentController, ref);
                  }
                : null,
            icon: const Icon(Icons.send),
          )
        ],
      ),
      body: SafeArea(
        child: Flex(
          direction: Axis.vertical,
          children: [
            Expanded(
              flex: 4,
              child: comments.when(
                data: (comments) {
                  if (comments.isEmpty) {
                    return const SingleChildScrollView(
                      child: EmptyContentWithTextAnimationView(
                          text: Strings.noCommentsYet),
                    );
                  } else {
                    return RefreshIndicator(
                        child: ListView.builder(
                          itemCount: comments.length,
                          padding: const EdgeInsets.all(8),
                          itemBuilder: (context, index) {
                            final comment = comments.elementAt(index);
                            return CommentTile(
                              comment: comment,
                            );
                          },
                        ),
                        onRefresh: () {
                          ref.refresh(postCommentsProvider(request.value));
                          return Future.delayed(const Duration(seconds: 1));
                        });
                  }
                },
                error: (error, stackTrace) => const ErrorAnimationView(),
                loading: () => const LoadingAnimationView(),
              ),
            ),
            Expanded(
              flex: 1,
              child: Align(
                alignment: Alignment.bottomCenter,
                child: Padding(
                  padding: const EdgeInsets.only(left: 8.0, right: 8),
                  child: TextField(
                    controller: commentController,
                    textInputAction: TextInputAction.send,
                    onSubmitted: (comment) {
                      if (comment.isNotEmpty) {
                        _submitCommentWithController(
                          commentController,
                          ref,
                        );
                      }
                    },
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: Strings.writeYourCommentHere,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _submitCommentWithController(
      TextEditingController controller, WidgetRef ref) async {
    final userId = ref.read(userIdProvider);
    if (userId == null) {
      return;
    }
    final isSent = await ref.read(sendCommentProvider.notifier).sendComment(
          fromUserId: userId,
          onPostId: postId,
          comment: controller.text,
        );
    if (isSent) {
      controller.clear();
      dismissKeyboard();
    }
  }
}
