import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:logger/logger.dart';
import 'package:spacirtrasa/services/app_user.dart';

final _log = Logger();
final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

Future<void> signInWithGoogle() async {
  try {
    // Trigger the authentication flow
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

    // Obtain the auth details from the request
    final GoogleSignInAuthentication? googleAuth = await googleUser?.authentication;

    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth?.accessToken,
      idToken: googleAuth?.idToken,
    );

    final userCredential = await _firebaseAuth.signInWithCredential(credential);
    if (userCredential.user == null) throw ("User is null");

    await createAppUserIfNeeded(userCredential.user!.uid);
  } catch (e) {
    _log.f("Exception during signing in: $e");
  }
}

Future<void> signInAnonymously() async {
  try {
    await _firebaseAuth.signInAnonymously();
  } on FirebaseAuthException catch (e) {
    switch (e.code) {
      case "operation-not-allowed":
        _log.f("Anonymous auth hasn't been enabled for this project.");
        break;
      default:
        _log.f("Unknown error occurred during anonymous login: $e");
    }
  }
}

Future<void> signOut() async {
  await GoogleSignIn().signOut();
  await _firebaseAuth.signOut();
  await signInAnonymously();
  _log.t("User is signed out");
}
