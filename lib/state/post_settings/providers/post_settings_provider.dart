import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:instagram_app/state/post_settings/models/notifiers/post_settings_notifiers.dart';
import 'package:instagram_app/state/post_settings/models/post_settings.dart';

final postSettingProvider =
    StateNotifierProvider<PostSettingsNotifier, Map<PostSetting, bool>>(
  (ref) {
    return PostSettingsNotifier();
  },
);
