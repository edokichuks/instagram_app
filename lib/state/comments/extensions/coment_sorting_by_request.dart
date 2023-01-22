import 'package:instagram_app/enums.date_sorting.dart';
import 'package:instagram_app/state/comments/models/coment.dart';
import 'package:instagram_app/state/comments/models/post_comment_requests.dart';

extension Sorting on Iterable<Comment> {
  Iterable<Comment> applySortingfrom(RequestForPostAndComment request) {
    if (request.sortByCreatedAt) {
      final sortedDocument = toList()
        ..sort(
          (a, b) {
            switch (request.dateSorting) {
              case DateSorting.newestOnTop:
                return b.createdAt.compareTo(a.createdAt);

              case DateSorting.oldestOnTop:
                return a.createdAt.compareTo(b.createdAt);
            }
          },
        );
      return sortedDocument;
    } else {
      return this;
    }
  }
}
