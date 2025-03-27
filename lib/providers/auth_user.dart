import 'package:firebase_auth/firebase_auth.dart';
import 'package:logger/logger.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'generated/auth_user.g.dart';

@riverpod
class AuthUser extends _$AuthUser {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final log = Logger();

  @override
  User? build() {
    final authStateChangesSubscription = _firebaseAuth.authStateChanges().listen(
      (User? user) => log.i("AuthStateChanged with user: $user"),
    );
    ref.onDispose(() => authStateChangesSubscription.cancel());

    return _firebaseAuth.currentUser;
  }
}
