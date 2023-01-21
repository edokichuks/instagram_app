import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:instagram_app/state/auth/providers/user_id-provider.dart';
import 'package:instagram_app/state/image_upload/models/file_type.dart';
import 'package:instagram_app/state/image_upload/models/thumbnail_request.dart';
import 'package:instagram_app/state/image_upload/provider/image_uploader_provider.dart';
import 'package:instagram_app/state/post_settings/models/post_settings.dart';
import 'package:instagram_app/state/post_settings/providers/post_settings_provider.dart';
import 'package:instagram_app/views/components/file_thumbnail_view.dart';
import 'package:instagram_app/views/constants/string.dart';

class CreateNewPostView extends StatefulHookConsumerWidget {
  const CreateNewPostView(
      {required this.fileType, required this.fileToPost, Key? key})
      : super(key: key);
  final File fileToPost;
  final FileType fileType;
  @override
  ConsumerState<CreateNewPostView> createState() => _CreateNewPostViewState();
}

class _CreateNewPostViewState extends ConsumerState<CreateNewPostView> {
  @override
  Widget build(BuildContext context) {
    final thumbnailRequest = ThumbnailRequest(
      file: widget.fileToPost,
      fileType: widget.fileType,
    );
    final postSettings = ref.watch(postSettingProvider);
    final postController = useTextEditingController();

    final isPostButtonEnabled = useState(false);
    useEffect(
      () {
        void Listener() {
          isPostButtonEnabled.value = postController.text.isNotEmpty;
        }

        postController.addListener(Listener);
      },
      [
        postController,
      ],
    );

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          Strings.createNewPost,
        ),
        actions: [
          IconButton(
            onPressed: isPostButtonEnabled.value
                ? () async {
                    final userId = ref.read(userIdProvider);
                    if (userId == null) {
                      return;
                    }
                    final message = postController.text;
                    final isUploaded = await ref
                        .read(imageUploaderProvider.notifier)
                        .upload(
                            file: widget.fileToPost,
                            fileType: widget.fileType,
                            message: message,
                            postSetting: postSettings,
                            userId: userId);
                    if (isUploaded && mounted) {
                      Navigator.of(context).pop();
                    }
                  }
                : null,
            icon: const Icon(
              Icons.send,
            ),
          )
        ],
      ),
      body: SingleChildScrollView(
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
        FileThumbnailView(thumbnailRequest),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: TextField(
            decoration: const InputDecoration(
              labelText: Strings.pleaseWriteYourMessageHere,
            ),
            autofocus: true,
            maxLines: null,
            controller: postController,
          ),
        ),
        ...PostSetting.values.map(
          (postSetting) => ListTile(
            title: Text(postSetting.title),
            subtitle: Text(postSetting.description),
            trailing: Switch(
              value: postSettings[postSetting] ?? false,
              onChanged: (isOn) {
                ref
                    .read(postSettingProvider.notifier)
                    .setSetting(postSetting, isOn);
              },
            ),
          ),
        )
      ])),
    );
  }
}
