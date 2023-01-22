import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:instagram_app/state/comments/extensions/coment_sorting_by_request.dart';
import 'package:instagram_app/state/comments/models/coment.dart';
import 'package:instagram_app/state/comments/models/post_comment_requests.dart';
import 'package:instagram_app/state/constants/firebase_collection_name.dart';
import 'package:instagram_app/state/constants/firebase_field_name.dart';

final postCommentsProvider = StreamProvider.family
    .autoDispose<Iterable<Comment>, RequestForPostAndComment>(
  (ref, RequestForPostAndComment request) {
    final controller = StreamController<Iterable<Comment>>();

    final sub = FirebaseFirestore.instance
        .collection(FirebaseCollectionName.comments)
        .where(FirebaseFieldName.postId, isEqualTo: request.postId)
        .snapshots()
        .listen((event) {
      final documents = event.docs;

      final limitedDocuments =
          request.limit != null ? documents.take(request.limit!) : documents;

      final comments = limitedDocuments
          .where(
            (element) => !element.metadata.hasPendingWrites,
          )
          .map(
            (document) => Comment(
              id: document.id,
              document.data(),
            ),
          );
      final result = comments.applySortingfrom(request);
      controller.sink.add(result);
    });

    ref.onDispose(() {
      sub.cancel();
      controller.close();
    });
    return controller.stream;
  },
);
