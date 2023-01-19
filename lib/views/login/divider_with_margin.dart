import 'package:flutter/material.dart';

class DividerWithMargin extends StatelessWidget {
  const DividerWithMargin({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: const [
        SizedBox(
          height: 40,
        ),
        Divider(
          thickness: 0.5,
        ),
        SizedBox(
          height: 40,
        ),
      ],
    );
  }
}
