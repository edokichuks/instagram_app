import 'package:flutter/material.dart';
import 'package:instagram_app/views/components/animations/empty_contents_animations_view.dart';

class EmptyContentWithTextAnimationView extends StatelessWidget {
  final String text;

  const EmptyContentWithTextAnimationView({
    Key? key,
    required this.text,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(32.0),
            child: Text(
              text,
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    color: Colors.white54,
                  ),
            ),
          ),
          const EmptyContentAnimationView(),
        ],
      ),
    );
  }
}
