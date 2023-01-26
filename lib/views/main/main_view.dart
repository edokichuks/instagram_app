import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:instagram_app/state/auth/providers/auth_state_provider.dart';
import 'package:instagram_app/state/image_upload/helpers/image_picker.dart';
import 'package:instagram_app/state/image_upload/models/file_type.dart';
import 'package:instagram_app/state/post_settings/providers/post_settings_provider.dart';
import 'package:instagram_app/views/components/dialogs/alert_dialog_model.dart';
import 'package:instagram_app/views/components/dialogs/logout_dialog.dart';
import 'package:instagram_app/views/constants/string.dart';
import 'package:instagram_app/views/create_new_post/create_new_post_view.dart';
import 'package:instagram_app/views/tabs/home/home_view.dart';
import 'package:instagram_app/views/tabs/search/search_view.dart';
import 'package:instagram_app/views/tabs/users_posts/user_posts_view.dart';

class MainView extends ConsumerStatefulWidget {
  const MainView({Key? key}) : super(key: key);

  @override
  ConsumerState<MainView> createState() => _MainViewState();
}

class _MainViewState extends ConsumerState<MainView> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          title: const Text(
            Strings.appName,
          ),
          actions: [
            IconButton(
              onPressed: () async {
                final videoFile =
                    await ImagePickerHelper.pickVideoFromGallery();
                if (videoFile == null) {
                  return;
                }
                ref.refresh(postSettingProvider);

                if (!mounted) {
                  return;
                }
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) {
                      return CreateNewPostView(
                        fileType: FileType.video,
                        fileToPost: videoFile,
                      );
                    },
                  ),
                );
              },
              icon: const FaIcon(FontAwesomeIcons.film),
            ),
            IconButton(
              onPressed: () async {
                final imageFile =
                    await ImagePickerHelper.pickImageFromGallery();
                if (imageFile == null) {
                  return;
                }
                ref.refresh(postSettingProvider);

                if (!mounted) {
                  return;
                }
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) {
                      return CreateNewPostView(
                        fileType: FileType.image,
                        fileToPost: imageFile,
                      );
                    },
                  ),
                );
              },
              icon: const Icon(Icons.add_photo_alternate_outlined),
            ),
            IconButton(
              onPressed: () async {
                final shouldLogOut = await const LogoutDialog()
                    .present(context)
                    .then((value) => value ?? false);

                if (shouldLogOut) {
                  await ref.read(authStateProvider.notifier).logOut();
                }
              },
              icon: const Icon(Icons.logout),
            ),
          ],
          bottom: const TabBar(
            tabs: [
              Tab(
                icon: Icon(
                  Icons.person,
                ),
              ),
              Tab(
                icon: Icon(
                  Icons.search,
                ),
              ),
              Tab(
                icon: Icon(
                  Icons.home,
                ),
              )
            ],
          ),
        ),
        body: const TabBarView(children: [
          UserPostView(),
          SearchView(),
          HomeView(),
        ]),
      ),
    );
  }
}
