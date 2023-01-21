
import 'package:instagram_app/views/constants/string.dart';

enum PostSetting {
  allowLikes(
    title: Strings.allowLikesTitle,
    description: Strings.allowLikesDecription,
    storageKey: Strings.allowLikesStorageKey,
  ),

  allowComments(
    title: Strings.allowCommentsTitle,
    description: Strings.allowCommentDescription,
    storageKey: Strings.allowCommentStorageKey,
  );

  final String title;
  final String description;
  final String storageKey;

  const PostSetting({
    required this.title,
    required this.description,
    required this.storageKey,
  });
}
