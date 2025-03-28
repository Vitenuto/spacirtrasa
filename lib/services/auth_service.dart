import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:logger/logger.dart';

class AuthService {
  static final log = Logger();
  static final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  static String? getUserReadable() => _firebaseAuth.currentUser != null ? ("${_firebaseAuth.currentUser!.displayName ?? 'Anonymous'}, UID: ${_firebaseAuth.currentUser!.uid}") : null;

  static Future<void> signInWithGoogle() async {
    try {
      // Trigger the authentication flow
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

      // Obtain the auth details from the request
      final GoogleSignInAuthentication? googleAuth = await googleUser?.authentication;

      // Create a new credential
      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth?.accessToken,
        idToken: googleAuth?.idToken,
      );

      // Once signed in, return the UserCredential
      await _firebaseAuth.signInWithCredential(credential);
    } on Exception catch (e) {
      log.f("FirebaseAuth.signInWithCredential() throws an exception: $e");
    }
  }

  static Future<void> signInAnonymously() async {
    try {
      await _firebaseAuth.signInAnonymously();
    } on FirebaseAuthException catch (e) {
      switch (e.code) {
        case "operation-not-allowed":
          log.f("Anonymous auth hasn't been enabled for this project.");
          break;
        default:
          log.f("Unknown error occurred during anonymous login: $e");
      }
    }
  }

  static Future<void> signOut() async {
    await _firebaseAuth.signOut();
    log.t("User is signed out");
  }
}
