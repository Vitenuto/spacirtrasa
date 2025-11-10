import 'package:firebase_auth/firebase_auth.dart';
import 'package:logger/logger.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part '../generated/user/firebase_user.g.dart';

@riverpod
class FirebaseUserProvider extends _$FirebaseUserProvider {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final _log = Logger();

  @override
  User? build() {
    final authStateChangesSubscription = _firebaseAuth.authStateChanges().listen(
      _onAuthStateDataUpdate,
    );
    ref.onDispose(() => authStateChangesSubscription.cancel());
    return _firebaseAuth.currentUser?.isAnonymous == true ? null : _firebaseAuth.currentUser;
  }

  void _onAuthStateDataUpdate(User? user) {
    if (state?.uid == user?.uid) {
      return;
    }
    _log.i("AuthStateChanged with user: $user");
    state = user?.isAnonymous == true ? null : user;
  }
}
