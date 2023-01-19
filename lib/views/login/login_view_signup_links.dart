import 'package:flutter/material.dart';
import 'package:instagram_app/views/constants/string.dart';
import 'package:instagram_app/views/components/rich_text/base_text.dart';
import 'package:instagram_app/views/components/rich_text/rich_text_widget.dart';
import 'package:url_launcher/url_launcher.dart';

class LoginViewSignUpLink extends StatelessWidget {
  const LoginViewSignUpLink({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return RichTextWidget(
      texts: [
        BaseText.plain(text: Strings.dontHaveAccount),
        BaseText.plain(text: Strings.signUpon),
        BaseText.link(
            text: Strings.facebook,
            onTapped: () {
              launchUrl(
                Uri.parse(Strings.facebookSignupUrl),
              );
            }),
        BaseText.plain(text: Strings.orCreateAnAccount),
        BaseText.link(
            text: Strings.google,
            onTapped: () {
              launchUrl(
                Uri.parse(Strings.googleSignupUrl),
              );
            }),
      ],
      styleForAll: Theme.of(context).textTheme.subtitle1?.copyWith(
            height: 1.5,
          ),
    );
  }
}
