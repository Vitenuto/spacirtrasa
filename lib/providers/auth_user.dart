import 'package:firebase_auth/firebase_auth.dart';
import 'package:logger/logger.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'generated/auth_user.g.dart';

@riverpod
class AuthUserProvider extends _$AuthUserProvider {
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
    _log.i("AuthStateChanged with user: $user");
    state = user?.isAnonymous == true ? null : user;
  }
}
