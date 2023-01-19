import 'package:flutter/foundation.dart';

@immutable
class Constants {
  static const accountExitsWithDifferentCredential =
      'account-exists-with-different-credential';
  static const googleCom = 'google.com';
  static const emailScope = 'email';

  ///Private constant constructor for the class so it can't be initialized from outside class
  const Constants._();
}
