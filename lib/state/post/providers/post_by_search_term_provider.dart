import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:instagram_app/state/constants/firebase_collection_name.dart';
import 'package:instagram_app/state/constants/firebase_field_name.dart';
import 'package:instagram_app/state/post/models/post.dart';
import 'package:instagram_app/state/post/typedefs/search_term.dart';

final postBySearchTermProvider =
    StreamProvider.family.autoDispose<Iterable<Post>, SearchTerm>(
  (ref, SearchTerm searchTerm) {
    final controller = StreamController<Iterable<Post>>();
    final sub = FirebaseFirestore.instance
        .collection(
          FirebaseCollectionName.posts,
        )
        .orderBy(
          FirebaseFieldName.createAt,
          descending: true,
        )
        .snapshots()
        .listen((snapshot) {
      final post = snapshot.docs
          .map(
            (doc) => Post(
              postId: doc.id,
              json: doc.data(),
            ),
          )
          .where(
            (post) => post.message.toLowerCase().contains(
                  searchTerm.toLowerCase(),
                ),
          );

      controller.sink.add(post);
    });

    ref.onDispose(() {
      sub.cancel();
      controller.close();
    });

    return controller.stream;
  },
);
