import 'dart:developer';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart' show immutable;
import 'package:instagram_app/state/constants/firebase_collection_name.dart';
import 'package:instagram_app/state/constants/firebase_field_name.dart';
import 'package:instagram_app/state/post/typedefs/user_id.dart';
import 'package:instagram_app/state/user_info/models/user_info_payload.dart';

@immutable
class UserInfoStorage {
  const UserInfoStorage();
  Future<bool> saveUserInfo({
    required UserId userId,
    required String displayName,
    required String? email,
  }) async {
    try {
      ///first check if we have the current user info before
      final userInfo = await FirebaseFirestore.instance
          .collection(FirebaseCollectionName.users)
          .where(
            FirebaseFieldName.userId,
            isEqualTo: userId,
          )
          .limit(1)
          .get();

      if (userInfo.docs.isNotEmpty) {
        ///we already hace this user's info
        await userInfo.docs.first.reference.update({
          FirebaseFieldName.displayName: displayName,
          FirebaseFieldName.email: email ?? '',
        });
        return true;
      }

      ///we don't have this info from before ...we create a new user
      final payload = UserInfoPayload(
        userId: userId,
        displayName: displayName,
      );
      await FirebaseFirestore.instance
          .collection(
            FirebaseCollectionName.users,
          )
          .add(payload);
      return true;
    } catch (e) {
      log('error: ${e.toString()}');
      return false;
    }
  }
}
