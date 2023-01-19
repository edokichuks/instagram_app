import 'dart:developer' as devtools show log;

import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:instagram_app/state/auth/backend/authenticator.dart';
import 'package:instagram_app/state/auth/providers/auth_state_provider.dart';
import 'package:instagram_app/state/auth/providers/is_logged_in_provider.dart';
import 'package:instagram_app/views/components/loading/loading_screen.dart';
import 'firebase_options.dart';

extension Log on Object {
  void log() => devtools.log(toString());
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(
    const ProviderScope(
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'instagram app',
      theme: ThemeData(
        brightness: Brightness.dark,
        primarySwatch: Colors.blue,
      ),
      themeMode: ThemeMode.dark,
      darkTheme: ThemeData(
        brightness: Brightness.dark,
        primarySwatch: Colors.blueGrey,
        indicatorColor: Colors.blueGrey,
      ),
      debugShowCheckedModeBanner: false,
      home: Consumer(builder: (context, ref, child) {
        final isLoggedIn = ref.watch(isLoggedInProvider);

        if (isLoggedIn) {
          return const MainView();
        } else {
          return const LoginView();
        }
      }),
    );
  }
}

class MainView extends StatelessWidget {
  const MainView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      appBar: AppBar(
        title: const Text('Main View'),
      ),
      body: Consumer(builder: (_, ref, child) {
        return TextButton(
          onPressed: () async {
            LoadingScreen.instance()
                .show(context: context, text: 'Hello World');
            // await ref.read(authStateProvider.notifier).logOut();
          },
          child: const Text(
            'Logout',
          ),
        );
      }),
    );
  }
}

class LoginView extends ConsumerWidget {
  const LoginView({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Login View'),
      ),
      body: Column(
        children: [
          TextButton(
            onPressed: ref.read(authStateProvider.notifier).loginWithGoogle,
            child: const Text('Sign In with Google'),
          ),
          TextButton(
            onPressed: ref.read(authStateProvider.notifier).loginWithFacebook,
            child: const Text('Sign In with Facebook'),
          ),
        ],
      ),
    );
  }
}
