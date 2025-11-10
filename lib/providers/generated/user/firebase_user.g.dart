// GENERATED CODE - DO NOT MODIFY BY HAND

part of '../../user/firebase_user.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(FirebaseUserProvider)
const firebaseUserProvider = FirebaseUserProviderProvider._();

final class FirebaseUserProviderProvider
    extends $NotifierProvider<FirebaseUserProvider, User?> {
  const FirebaseUserProviderProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'firebaseUserProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$firebaseUserProviderHash();

  @$internal
  @override
  FirebaseUserProvider create() => FirebaseUserProvider();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(User? value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<User?>(value),
    );
  }
}

String _$firebaseUserProviderHash() =>
    r'3d7ba75b11044445cb00904ae889a4bbb59f7dba';

abstract class _$FirebaseUserProvider extends $Notifier<User?> {
  User? build();
  @$mustCallSuper
  @override
  void runBuild() {
    final created = build();
    final ref = this.ref as $Ref<User?, User?>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<User?, User?>,
              User?,
              Object?,
              Object?
            >;
    element.handleValue(ref, created);
  }
}
