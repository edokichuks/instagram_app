import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:instagram_app/state/image_upload/models/thumbnail_request.dart';
import 'package:instagram_app/state/image_upload/provider/thumbnail_provider.dart';
import 'package:instagram_app/views/components/animations/loading_animation_view.dart';
import 'package:instagram_app/views/components/animations/small_error_animation_view.dart';

class FileThumbnailView extends ConsumerWidget {
  const FileThumbnailView(this.request, {Key? key}) : super(key: key);
  final ThumbnailRequest request;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final thumbnail = ref.watch(
      thumbnailProvider(
        request,
      ),
    );
    return thumbnail.when(
      loading: () {
        return const LoadingAnimationView();
      },
      error: (error, stackTrace) => const SmallErrorAnimationView(),
      data: (data) {
        return AspectRatio(
          aspectRatio: data.aspectRatio,
          child: data.image,
        );
      },
    );
  }
}
