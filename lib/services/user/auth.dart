import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:logger/logger.dart';
import 'package:spacirtrasa/services/user/firebase_app_user_service.dart';

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

Future<void> signOut() async {
  await GoogleSignIn().signOut();
  await _firebaseAuth.signOut();
  _log.t("User is signed out");
}
