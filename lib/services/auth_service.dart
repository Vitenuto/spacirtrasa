import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:logger/logger.dart';

class AuthService {
  static final log = Logger();
  static final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

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

  static Future<void> signOut() async {
    await _firebaseAuth.signOut();
    log.i("User is signed out");
  }
}
