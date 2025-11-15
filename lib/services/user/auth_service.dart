// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:google_sign_in/google_sign_in.dart';
// import 'package:logger/logger.dart';
// import 'package:spacirtrasa/services/user/firebase_app_user_service.dart';
//
// /**
//  * Based on https://isaacadariku.medium.com/google-sign-in-flutter-migration-guide-pre-7-0-versions-to-v7-version-cdc9efd7f182
//  */
// class AuthService {
//   final _log = Logger();
//   final _googleSignIn = GoogleSignIn.instance;
//   bool _isGoogleSignInInitialized = false;
//   GoogleSignInAccount? _currentUser;
//
//   GoogleSignInAccount? get currentUser => _currentUser;
//
//   bool get isSignedIn => _currentUser != null;
//
//   AuthService() {
//     _initializeGoogleSignIn();
//   }
//
//   Future<void> _initializeGoogleSignIn() async {
//     try {
//       await _googleSignIn.initialize();
//       _isGoogleSignInInitialized = true;
//       _log.t('Google Sign-In initialized successfully.');
//     } catch (e) {
//       _log.f('Failed to initialize Google Sign-In: $e');
//     }
//   }
//
//   /// Always check Google sign in initialization before use
//   Future<void> _ensureGoogleSignInInitialized() async {
//     if (!_isGoogleSignInInitialized) {
//       await _initializeGoogleSignIn();
//     }
//   }
//
//   Future<GoogleSignInAccount> signInWithGoogle() async {
//     await _ensureGoogleSignInInitialized();
//
//     try {
//       // authenticate() throws exceptions instead of returning null
//       final GoogleSignInAccount account = await _googleSignIn.authenticate(
//         scopeHint: ['email'], // Specify required scopes TODO: maybe unnecessary?
//       );
//       return account;
//     } on GoogleSignInException catch (e) {
//       _log.e(
//         'Google Sign In error: code: ${e.code.name} description:${e.description} details:${e.details}',
//         error: e,
//       );
//       rethrow;
//     } catch (error) {
//       _log.e('Unexpected Google Sign-In error: $error');
//       rethrow;
//     }
//   }
//
//   Future<GoogleSignInAccount?> attemptSilentSignIn() async {
//     await _ensureGoogleSignInInitialized();
//
//     try {
//       // attemptLightweightAuthentication can return Future or immediate result
//       final result = _googleSignIn.attemptLightweightAuthentication();
//
//       // Handle both sync and async returns
//       if (result is Future<GoogleSignInAccount?>) {
//         return await result;
//       } else {
//         return result as GoogleSignInAccount?;
//       }
//     } catch (error) {
//       _log.e('Silent sign-in failed: $error');
//       return null;
//     }
//   }
//
//   GoogleSignInAuthentication getAuthTokens(GoogleSignInAccount account) {
//     // authentication is now synchronous
//     return account.authentication;
//   }
//
//   /// TODO: most likely unnecessary
//   Future<String?> getAccessTokenForScopes(List<String> scopes) async {
//     await _ensureGoogleSignInInitialized();
//
//     try {
//       final authClient = _googleSignIn.authorizationClient;
//
//       // Try to get existing authorization
//       var authorization = await authClient.authorizationForScopes(scopes);
//
//       authorization ??= await authClient.authorizeScopes(
//         scopes,
//       ); // Request new authorization if none exists
//
//       return authorization.accessToken;
//     } catch (error) {
//       _log.e('Failed to get access token for scopes: $error');
//       return null;
//     }
//   }
//
//   Future<UserCredential> signInWithGoogleFirebase() async {
//     await _ensureGoogleSignInInitialized();
//
//     // Authenticate with Google
//     final GoogleSignInAccount googleUser = await _googleSignIn.authenticate(
//       scopeHint: ['email', 'profile'], // TODO: Test if necessary
//     );
//
//     // Get authorization for Firebase scopes if needed
//     final authClient = _googleSignIn.authorizationClient;
//     final authorization = await authClient.authorizationForScopes(['email']);
//
//     final googleAuth = getAuthTokens(googleUser);
//     final credential = GoogleAuthProvider.credential(
//       accessToken: authorization?.accessToken,
//       idToken: googleAuth.idToken,
//     );
//
//     final userCredential = await FirebaseAuth.instance.signInWithCredential(credential);
//
//     // Update local state
//     _currentUser = googleUser;
//     await createAppUserIfNeeded(userCredential.user!.uid);
//
//     return userCredential;
//   }
//
//   Future<void> signOut() async {
//     await _googleSignIn.signOut();
//     _currentUser = null;
//   }
// }
