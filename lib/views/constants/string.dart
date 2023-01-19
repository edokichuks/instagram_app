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
  static const comments = 'Comments';
  static const loading = 'Loading...';
  static const person = 'person';
  static const people = 'people';
  static const likedThis = 'liked this';

  static const delete = 'Delete';

  static const areYouSureWantToDeleteThis =
      'Are you sure you want to delete this';

  //log-out
  static const logOut = 'Log out';
  static const cancel = 'Cancel';
  static const areYouSureYouWantToLogOutOfTheApp =
      'Are you sure you want to log out of the app?';

  static const appName = 'Instant-gram';
  static const welcomeToAppName = 'Welcome to ${Strings.appName}';
  static const youHaveNoPosts =
      'You have not made a post yet. Press either the video-upload or the photo-upload buttons to the top of the screen in orfer to upload your first post!';
  static const noPostAvailable =
      'Nobody seems to have made any posts yet. why don\'t you take the first step and upload your first post';
  static const enterYourSearchTerm =
      'Enter your search term in order to get started. You can search in the description of all posts available in the system';

  static const facebook = 'Facebook ';
  static const facebookSignupUrl = 'https://www.facebook.com/signup';
  static const google = 'Google';
  static const googleSignupUrl = 'https://accounts.google.com/signup';
  static const logIntoYourAccount =
      'Log into your account using one of the options below.';
  static const writeYourCommentHere = 'Write your comment here...';
  static const checkOutThisPost = 'Check out this post';
  static const postDetails = 'Post Details';
  static const post = 'post';
  static const createNewPost = 'Create New Post';
  static const pleaseWriteYourMessageHere = 'Please write your message here';
  static const noCommentsYet =
      'Nobody has commented on this post yet. You can change that tho, and be the first person to comment';
  static const signUpon = 'Sign up on ';
  static const dontHaveAccount = 'Don\'t have an account\n';
  static const orCreateAnAccount = 'or create an account on ';

  const Strings._();
}
