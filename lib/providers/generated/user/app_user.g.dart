// GENERATED CODE - DO NOT MODIFY BY HAND

part of '../../user/app_user.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// AppUser provider that listens to both Firebase and local user providers.
/// If Firebase user is available, it takes precedence over the local user, however
/// at the beginning, automatically the local user is used until a Firebase user is available.

@ProviderFor(AppUserProvider)
const appUserProvider = AppUserProviderProvider._();

/// AppUser provider that listens to both Firebase and local user providers.
/// If Firebase user is available, it takes precedence over the local user, however
/// at the beginning, automatically the local user is used until a Firebase user is available.
final class AppUserProviderProvider
    extends $NotifierProvider<AppUserProvider, AppUser> {
  /// AppUser provider that listens to both Firebase and local user providers.
  /// If Firebase user is available, it takes precedence over the local user, however
  /// at the beginning, automatically the local user is used until a Firebase user is available.
  const AppUserProviderProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'appUserProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$appUserProviderHash();

  @$internal
  @override
  AppUserProvider create() => AppUserProvider();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(AppUser value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<AppUser>(value),
    );
  }
}

String _$appUserProviderHash() => r'4c47ff77fd085726025d20cfda234d485691900e';

/// AppUser provider that listens to both Firebase and local user providers.
/// If Firebase user is available, it takes precedence over the local user, however
/// at the beginning, automatically the local user is used until a Firebase user is available.

abstract class _$AppUserProvider extends $Notifier<AppUser> {
  AppUser build();
  @$mustCallSuper
  @override
  void runBuild() {
    final created = build();
    final ref = this.ref as $Ref<AppUser, AppUser>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AppUser, AppUser>,
              AppUser,
              Object?,
              Object?
            >;
    element.handleValue(ref, created);
  }
}
