import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:instagram_app/state/image_upload/typedef/is_loading.dart';
import 'package:instagram_app/state/post/notifiers/delete_post_state_notifier.dart';

final deletePostProvider =
    StateNotifierProvider<DeletePostStateNotifier, IsLoading>(
  (ref) => DeletePostStateNotifier(),
);
