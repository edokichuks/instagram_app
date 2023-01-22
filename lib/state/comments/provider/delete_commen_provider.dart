import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:instagram_app/state/comments/notifiers/delete_comment_notifier.dart';
import 'package:instagram_app/state/image_upload/typedef/is_loading.dart';

final deleteCommentProvider =
    StateNotifierProvider<DeleteCommentNotifier, IsLoading>(
  (ref) => DeleteCommentNotifier(),
);


