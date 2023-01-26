import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:instagram_app/views/components/search_grid_view.dart';
import 'package:instagram_app/views/constants/string.dart';
import 'package:instagram_app/views/extensions/dismiss_keyboard.dart';

class SearchView extends HookConsumerWidget {
  const SearchView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final controller = useTextEditingController();
    final searchTem = useState('');
    useEffect(
      () {
        controller.addListener(() {
          searchTem.value = controller.text;
        });
        return () {};
      },
      [controller],
    );
    return CustomScrollView(
      slivers: [
        SliverToBoxAdapter(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: controller,
              textInputAction: TextInputAction.search,
              decoration: InputDecoration(
                labelText: Strings.enterSearchTermHere,
                suffixIcon: IconButton(
                  onPressed: () {
                    controller.clear();
                    dismissKeyboard();
                  },
                  icon: const Icon(Icons.clear),
                ),
              ),
            ),
          ),
        ),
        SearchGridView(searchTerm: searchTem.value),
      ],
    );
  }
}
