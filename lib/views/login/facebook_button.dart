import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:instagram_app/views/constants/app_colors.dart';
import 'package:instagram_app/views/constants/string.dart';

class FacebookButton extends StatelessWidget {
  const FacebookButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        height: 44.0,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            FaIcon(
              FontAwesomeIcons.facebook,
              color: AppColors.facebookColor,
            ),
            const SizedBox(
              width: 10,
            ),
            const Text(
              Strings.facebook,
            ),
          ],
        ));
  }
}
