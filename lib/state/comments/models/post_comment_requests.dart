import 'package:flutter/foundation.dart' show immutable;
import 'package:instagram_app/enums.date_sorting.dart';
import 'package:instagram_app/state/post/typedefs/post_id.dart';

@immutable
class RequestForPostAndComment {
  final PostId postId;
  final bool sortByCreatedAt;
  final DateSorting dateSorting;
  final int? limit;

  const RequestForPostAndComment({
    required this.postId,
     this.sortByCreatedAt  = true,
    this.dateSorting = DateSorting.newestOnTop, 
     this.limit,
  });

  @override
  bool operator ==(covariant RequestForPostAndComment other) =>
      postId == other.postId &&
      sortByCreatedAt == other.sortByCreatedAt &&
      dateSorting == other.dateSorting &&
      limit == other.limit;

  @override
  int get hashCode => Object.hashAll([
        postId,
        sortByCreatedAt,
        dateSorting,
        limit,
      ]);
}
