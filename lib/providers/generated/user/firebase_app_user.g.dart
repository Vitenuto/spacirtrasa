// GENERATED CODE - DO NOT MODIFY BY HAND

part of '../../user/firebase_app_user.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(FirebaseAppUserProvider)
const firebaseAppUserProvider = FirebaseAppUserProviderProvider._();

final class FirebaseAppUserProviderProvider
    extends $NotifierProvider<FirebaseAppUserProvider, AppUser?> {
  const FirebaseAppUserProviderProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'firebaseAppUserProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$firebaseAppUserProviderHash();

  @$internal
  @override
  FirebaseAppUserProvider create() => FirebaseAppUserProvider();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(AppUser? value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<AppUser?>(value),
    );
  }
}

String _$firebaseAppUserProviderHash() =>
    r'e9667dc830715b958b39a5c8a40c3ed3eae64267';

abstract class _$FirebaseAppUserProvider extends $Notifier<AppUser?> {
  AppUser? build();
  @$mustCallSuper
  @override
  void runBuild() {
    final created = build();
    final ref = this.ref as $Ref<AppUser?, AppUser?>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AppUser?, AppUser?>,
              AppUser?,
              Object?,
              Object?
            >;
    element.handleValue(ref, created);
  }
}
