import 'dart:developer';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:instagram_app/state/auth/constants/constants.dart';
import 'package:instagram_app/state/auth/models/auth_result.dart';
import 'package:instagram_app/state/post/typedefs/user_id.dart';

class Authenticator {
  const Authenticator();
  UserId? get userId => FirebaseAuth.instance.currentUser?.uid;
  bool get isAlreadyLoggedIn => userId != null;
  String get displatName =>
      FirebaseAuth.instance.currentUser?.displayName ?? 'null_chuksDev';

  ///not used tho
  User? get currentUser => FirebaseAuth.instance.currentUser;

  String? get email => FirebaseAuth.instance.currentUser?.email;

  Future<void> logOut() async {
    await FirebaseAuth.instance.signOut();
    await GoogleSignIn().signOut();
    await FacebookAuth.instance.logOut();
  }

  Future<AuthResult> loginWithFacebook() async {
    final loginResult = await FacebookAuth.instance.login();
    final token = loginResult.accessToken?.token;
    if (token == null) {
      //user has aborted the loggin process
      return AuthResult.aborted;
    }

    final oauthCredentials = FacebookAuthProvider.credential(token);

    try {
      await FirebaseAuth.instance.signInWithCredential(oauthCredentials);
      return AuthResult.success;
    } on FirebaseAuthException catch (ex) {
      log(ex.toString() + 'Error from authenticator');
      final email = ex.email;
      final credential = ex.credential;

      if (ex.code == Constants.accountExitsWithDifferentCredential &&
          email != null &&
          credential != null) {
        final providers =
            await FirebaseAuth.instance.fetchSignInMethodsForEmail(email);

        if (providers.contains(Constants.googleCom)) {
          await loginWithGoogle();
          FirebaseAuth.instance.currentUser?.linkWithCredential(
            credential,
          );
        }
        return AuthResult.success;
      }
      return AuthResult.failure;
    }
  }

  Future<AuthResult> loginWithGoogle() async {
    final GoogleSignIn googleSignIn = GoogleSignIn(scopes: [
      Constants.emailScope,
    ]);
    log('email scope: ${Constants.emailScope}');
    log('logining in with google');
    final signInAccount = await googleSignIn.signIn();

    if (signInAccount == null) {
      log('account not created');
      return AuthResult.aborted;
    }
    log('sign in account details ${signInAccount.toString()}');
    final googleAuth = await signInAccount.authentication;

    final oauthCredentials = GoogleAuthProvider.credential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );
    log('before try');
    try {
      log('attempting to sign in with credientials');
      await FirebaseAuth.instance.signInWithCredential(oauthCredentials);
      return AuthResult.success;
    } catch (ex) {
      log('Failed in google $ex');

      return AuthResult.failure;
    }
  }
}
