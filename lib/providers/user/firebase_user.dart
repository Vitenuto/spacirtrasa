import 'dart:async';

import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:spacirtrasa/services/user/firebase_app_user_service.dart';
import 'package:spacirtrasa/utils/utils.dart';

part '../generated/user/firebase_user.g.dart';

const List<String> _scopes = <String>['email'];

@Riverpod(keepAlive: true)
class FirebaseUserProvider extends _$FirebaseUserProvider {
  static final _signIn = GoogleSignIn.instance;
  static final _firebaseAuth = FirebaseAuth.instance;
  StreamSubscription<GoogleSignInAuthenticationEvent>? _authenticationEventsSubscription;

  @override
  User? build() {
    logger.t("Building FirebaseUser provider...");
    final authStateChangesSubscription = _firebaseAuth.authStateChanges().listen((User? user) {
      logger.i("AuthStateChanged (thus updating firebaseUser state) with user: $user");
      state = user;
    });
    ref.onDispose(() => authStateChangesSubscription.cancel());
    return null;
  }

  Future<void> _initializeGoogleSignIn() async {
    if (_authenticationEventsSubscription != null) {
      // Already initialized
      return;
    }
    logger.t("Initializing Google Sign-In...");
    await _signIn.initialize();
    _authenticationEventsSubscription = _signIn.authenticationEvents.listen(
      _handleAuthenticationEvent,
    );
    _authenticationEventsSubscription!.onError(_handleAuthenticationError);
    ref.onDispose(_authenticationEventsSubscription!.cancel);
  }

  Future<User?> _handleAuthenticationEvent(GoogleSignInAuthenticationEvent event) async {
    final GoogleSignInAccount? user = switch (event) {
      GoogleSignInAuthenticationEventSignIn() => event.user,
      GoogleSignInAuthenticationEventSignOut() => null,
    };
    if (user == null) {
      return null;
    }

    // Proceed with firebase sign-in using Google credentials
    OAuthCredential credential = await _getCredentials(user);
    return await _signFirebaseUserIn(credential);
  }

  Future<User?> _signFirebaseUserIn(OAuthCredential credential) async {
    final firebaseUserCredential = await _firebaseAuth.signInWithCredential(credential);
    final firebaseUser = firebaseUserCredential.user;

    createAppUserIfNeeded(firebaseUser!.uid); // Ensure AppUser exists in Firestore
    return firebaseUser;
  }

  Future<OAuthCredential> _getCredentials(GoogleSignInAccount user) async {
    final GoogleSignInClientAuthorization? authorization = await user.authorizationClient
        .authorizationForScopes(_scopes);

    final credential = GoogleAuthProvider.credential(
      accessToken: authorization?.accessToken,
      idToken: user.authentication.idToken,
    );
    return credential;
  }

  Future<void> _handleAuthenticationError(Object e) async {
    logger.e("Handling authentication error: $e");
    state = null;
  }

  Future<void> handleSignIn() async {
    logger.i("Signing user in...");
    await _initializeGoogleSignIn();
    await _signIn.attemptLightweightAuthentication();
  }

  Future<void> handleSignOut() async {
    logger.i("Signing-out user: ${state?.email}");
    await _signIn.signOut();
    await _firebaseAuth.signOut();
  }

  Future<void> handleDeleteUser() async {
    logger.t("Deleting user: ${state?.email}");
    final user = _firebaseAuth.currentUser;
    if (user != null) {
      try {
        await user.delete();
        await _signIn.signOut();
        logger.i("User was successfully deleted.");
        Fluttertoast.showToast(msg: 'profile.remove-user-success'.tr());
      } catch (e) {
        logger.e("Error while deleting user: $e");
        Fluttertoast.showToast(msg: 'profile.remove-user-error'.tr());
      }
    }
  }
}
