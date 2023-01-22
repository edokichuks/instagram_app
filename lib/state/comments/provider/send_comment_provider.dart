import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:instagram_app/state/comments/notifiers/send_comment_notifier.dart';
import 'package:instagram_app/state/image_upload/typedef/is_loading.dart';

final sendCommentProvider =
    StateNotifierProvider<SendCommentNotifier, IsLoading>(
  (ref) => SendCommentNotifier(),
);
