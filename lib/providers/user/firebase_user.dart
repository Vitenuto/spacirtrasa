import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:spacirtrasa/services/user/firebase_app_user_service.dart';
import 'package:spacirtrasa/utils/utils.dart';

part '../generated/user/firebase_user.g.dart';

const List<String> _scopes = <String>['email'];

@Riverpod(keepAlive: true)
class FirebaseUserProvider extends _$FirebaseUserProvider {
  static final _signIn = GoogleSignIn.instance;

  @override
  User? build() {
    logger.i("Building AuthService provider...");
    _initializeGoogleSignIn();
    return null;
  }

  Future<void> _initializeGoogleSignIn() async {
    logger.t("Initializing Google Sign-In...");
    unawaited(
      _signIn.initialize().then((_) {
        _signIn.authenticationEvents
            .listen(_handleAuthenticationEvent)
            .onError(_handleAuthenticationError);

        /// This example always uses the stream-based approach to determining
        /// which UI state to show, rather than using the future returned here,
        /// if any, to conditionally skip directly to the signed-in state.
        _signIn.attemptLightweightAuthentication();
      }),
    );
  }

  Future<void> _handleAuthenticationEvent(GoogleSignInAuthenticationEvent event) async {
    final GoogleSignInAccount? user = switch (event) {
      GoogleSignInAuthenticationEventSignIn() => event.user,
      GoogleSignInAuthenticationEventSignOut() => null,
    };
    if (user == null) {
      state = null;
      return;
    }

    final GoogleSignInClientAuthorization? authorization = await user.authorizationClient
        .authorizationForScopes(_scopes);

    final credential = GoogleAuthProvider.credential(
      accessToken: authorization?.accessToken,
      idToken: user.authentication.idToken,
    );

    final firebaseUserCredential = await FirebaseAuth.instance.signInWithCredential(credential);
    final firebaseUser = firebaseUserCredential.user;

    createAppUserIfNeeded(firebaseUser!.uid); // Ensure AppUser exists in Firestore
    logger.t("Successfully obtained firebase user");
    state = firebaseUser;
  }

  Future<void> _handleAuthenticationError(Object e) async {
    logger.e("Handling authentication error: $e");
    state = null;
  }

  Future<void> handleSignIn() async {
    final user = await _signIn.attemptLightweightAuthentication();
    logger.i("Signing user in, signed user: $user");
  }

  Future<void> handleSignOut() async {
    logger.i("Signing-out user: ${state?.email}");
    await _signIn.signOut();
  }
}
