import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:instagram_app/enums.date_sorting.dart';
import 'package:instagram_app/state/comments/models/post_comment_requests.dart';
import 'package:instagram_app/state/comments/provider/specific_post_comment_provider.dart';
import 'package:instagram_app/state/post/models/post.dart';
import 'package:instagram_app/state/post/providers/can_current_user_delete_post_provider.dart';
import 'package:instagram_app/state/post/providers/delete_post_provider.dart';
import 'package:instagram_app/views/components/animations/small_error_animation_view.dart';
import 'package:instagram_app/views/components/comment/compact_comment_colume..dart';
import 'package:instagram_app/views/components/dialogs/alert_dialog_model.dart';
import 'package:instagram_app/views/components/dialogs/delete_dialog.dart';
import 'package:instagram_app/views/components/like_button.dart';
import 'package:instagram_app/views/components/likes_count_view.dart';
import 'package:instagram_app/views/components/post/image_or_video_ciew.dart';
import 'package:instagram_app/views/components/post/post_date_view.dart';
import 'package:instagram_app/views/components/post/post_display_name_and_message_view.dart';
import 'package:instagram_app/views/constants/string.dart';
import 'package:instagram_app/views/post_coment/post_coment_view.dart';
import 'package:share_plus/share_plus.dart';

class PostDetailsView extends ConsumerStatefulWidget {
  final Post post;
  const PostDetailsView({
    super.key,
    required this.post,
  });

  @override
  ConsumerState<PostDetailsView> createState() => _PostDetailsViewState();
}

class _PostDetailsViewState extends ConsumerState<PostDetailsView> {
  @override
  Widget build(BuildContext context) {
    final request = RequestForPostAndComment(
      postId: widget.post.postId,
      limit: 3,
      sortByCreatedAt: true,
      dateSorting: DateSorting.newestOnTop,
    );
    final postWithComments =
        ref.watch(specificPostWithCommentsProvider(request));

    final canDeletePost = ref.watch(
      canCurrentUserDeletePostProvider(widget.post),
    );
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          Strings.postDetails,
        ),
        actions: [
          //share button
          postWithComments.when(
            data: (postWithComment) {
              return IconButton(
                  onPressed: () {
                    final url = postWithComment.post.fileUrl;
                    Share.share(
                      url,
                      subject: 'Check out this post',
                    );
                  },
                  icon: const Icon(Icons.share));
            },
            error: (error, stackTrace) => const SmallErrorAnimationView(),
            loading: () => const Center(
              child: CircularProgressIndicator(),
            ),
          ),

          ///delete
          if (canDeletePost.value ?? false)
            IconButton(
              icon: const Icon(Icons.delete),
              onPressed: () async {
                final shouldDeletePost = await const DeleteDialog(
                        titleOfObjectToDelete: Strings.post)
                    .present(context)
                    .then((value) => value ?? false);
                if (shouldDeletePost) {
                  await ref
                      .read(deletePostProvider.notifier)
                      .deletPost(post: widget.post);
                  if (mounted) {
                    Navigator.pop(context);
                  }
                }
              },
            ),
        ],
      ),
      body: postWithComments.when(
        data: (postWithComment) {
          final postId = postWithComment.post.postId;

          return SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                PostImageOrVideoView(
                  post: postWithComment.post,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    //if post allows like
                    if (postWithComment.post.allowLikes)
                      LikeButton(
                        postId: postId,
                      ),

                    if (postWithComment.post.allowComments)
                      IconButton(
                        icon: const Icon(
                          Icons.mode_comment_outlined,
                        ),
                        onPressed: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) =>
                                  PostCommentView(postId: postId),
                            ),
                          );
                        },
                      )
                  ],
                ),
                //show Divider
                PostDisplayNameAndMessageView(
                  post: postWithComment.post,
                ),
                PostDateView(
                  dateTime: postWithComment.post.createdAt,
                ),
                const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Divider(
                    color: Colors.white70,
                  ),
                ),
                CompactCommentConlume(
                  comments: postWithComment.comments,
                ),
                if (postWithComment.post.allowLikes)
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      children: [
                        LikesCountView(
                          postId: postId,
                        ),
                      ],
                    ),
                  ), 
                  // add spacing to bottom
                const SizedBox(
                  height: 100,
                ),
              ],
            ),
          );
        },
        error: (error, stackTrace) => const SmallErrorAnimationView(),
        loading: () => const Center(
          child: CircularProgressIndicator(),
        ),
      ),
    );
  }
}
