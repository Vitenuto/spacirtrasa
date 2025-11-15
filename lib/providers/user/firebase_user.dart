import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:logger/logger.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:spacirtrasa/services/user/firebase_app_user_service.dart';

part '../generated/user/firebase_user.g.dart';

const List<String> _scopes = <String>['email'];

@Riverpod(keepAlive: true)
class FirebaseUserProvider extends _$FirebaseUserProvider {
  final _log = Logger();
  static final _signIn = GoogleSignIn.instance;

  @override
  User? build() {
    _log.i("Building AuthService provider...");
    _initializeGoogleSignIn();
    return null;
  }

  Future<void> _initializeGoogleSignIn() async {
    _log.t("Initializing Google Sign-In...");
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
    _log.t("Successfully obtained firebase user");
    state = firebaseUser;
  }

  Future<void> _handleAuthenticationError(Object e) async {
    _log.e("Handling authentication error: $e");
    state = null;
  }

  Future<void> handleSignIn() async {
    final user = await _signIn.attemptLightweightAuthentication();
    _log.i("Signing user in, signed user: $user");
  }

  Future<void> handleSignOut() async {
    _log.i("Signing-out user: ${state?.email}");
    await _signIn.signOut();
  }
}
