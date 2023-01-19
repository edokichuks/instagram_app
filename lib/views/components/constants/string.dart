import 'package:flutter/foundation.dart' show immutable;

@immutable
class Strings {
  static const allowLikesTitle = 'Allow likes';
  static const allowLikesDecription =
      'By allowing likes, users will be able to press the like button on your post.';
  static const allowLikesStorageKey = 'allow_likes';
  static const allowCommentsTitle = 'Allow comments';
  static const allowCommentDescription =
      'By allowing comments, users will be able to comment on your post';
  static const allowCommentStorageKey = 'allow_comments';

  static const comment = 'comment';
  static const loading = 'Loading...';
  static const person = 'person';
  static const people = 'people';
  static const likedThis = 'liked this';

 static const delete = 'Delete';

  static const areYouSureWantToDeleteThis = 'Are you sure you want to delete this';

  //log-out
  static const logOut = 'Log out';
  static const cancel = 'Cancel';
  static const areYouSureYouWantToLogOutOfTheApp = 'Are you sure you want to log out of the app?';

  const Strings._();
}
